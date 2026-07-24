class AmazonPdfsController < ApplicationController
  before_action :authenticate_director!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_amazon_pdf , only: [:show, :edit, :update, :destroy]

  def index
    @programs = @school.programs.order(:short_name, :name)
    @selected_program_id = params[:program_id].presence
    @selected_program = @programs.find_by(id: @selected_program_id)
    @amazon_pdfs = AmazonPdf.library_documents.includes(:program).order(type_of_pdf_group: :desc)
    @selected_group = params[:group].presence

    if @selected_group.present? && @selected_group != 'All Documents'
      @amazon_pdfs = @amazon_pdfs.where(type_of_pdf_group: @selected_group)
    end

    if @selected_program.present?
      @amazon_pdfs = @amazon_pdfs.where(program_id: @selected_program.id)
    end

    @grouped_amazon_pdfs = @amazon_pdfs.order(:event_date).group_by { |pdf| pdf.type_of_pdf_group }
    @ordered_pdfs = @grouped_amazon_pdfs.sort_by { |group_name, pdfs| AmazonPdf::GROUP_ORDER.index(group_name) || 999 }
  end

  def student_forms
    @amazon_pdfs = AmazonPdf.student_forms.order(name: :desc)
  end

  def new
    @amazon_pdfs = AmazonPdf.all
    @amazon_pdf = AmazonPdf.new
    @amazon_pdf.source_mode = amazon_pdf_source_mode
    # When a program page links here, keep that program preselected for faster uploads.
    @amazon_pdf.program_id = params[:program_id] if params[:program_id].present?
  end

  def edit
    @amazon_pdf.source_mode = amazon_pdf_source_mode(@amazon_pdf)
  end

  def update
    @amazon_pdf.assign_attributes(amazon_pdf_base_params)
    @amazon_pdf.source_mode = amazon_pdf_source_mode(@amazon_pdf)
    purge_pdf_after_save = apply_document_source(@amazon_pdf)

    if @amazon_pdf.save
      @amazon_pdf.pdf.purge_later if purge_pdf_after_save
      flash[:notice] = 'PDF was successfully updated.'
      redirect_to amazon_pdf_path(@amazon_pdf)
    else
      @amazon_pdf.source_mode = amazon_pdf_source_mode(@amazon_pdf)
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @amazon_pdf = AmazonPdf.new(amazon_pdf_base_params)
    @amazon_pdf.director = current_director
    @amazon_pdf.source_mode = amazon_pdf_source_mode(@amazon_pdf)
    purge_pdf_after_save = apply_document_source(@amazon_pdf)

    if @amazon_pdf.save
      @amazon_pdf.pdf.purge_later if purge_pdf_after_save
      # Program-page inline uploads send a return_to path; the regular PDFs page falls back here.
      redirect_path = amazon_pdf_params[:return_to].presence
      target_path = redirect_path&.start_with?('/') ? redirect_path : amazon_pdfs_path
      redirect_to(target_path, notice: 'Document saved successfully.')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    if @amazon_pdf
      @amazon_pdf.destroy
      flash[:notice] = "PDF was successfully deleted."
    else
      flash[:alert] = "PDF could not be deleted."
    end

    redirect_to amazon_pdfs_path
  end

  private

  def parse_datetime(date)
    DateTime.strptime(date, '%m/%d/%Y %I:%M %p')
  end

  def set_amazon_pdf
    @amazon_pdf = AmazonPdf.find(params[:id])
  end

  def amazon_pdf_params
    params.require(:amazon_pdf).permit(:name, :type_of_pdf_group, :program_id, :event_date, :pdf, :linked_document_url, :source_mode, :return_to)
  end

  def amazon_pdf_base_params
    amazon_pdf_params.except(:pdf, :source_mode, :return_to)
  end

  def amazon_pdf_source_mode(record = nil)
    raw_source_mode = params[:source_mode].presence || params.dig(:amazon_pdf, :source_mode).presence
    raw_source_mode.presence_in(AmazonPdf::SOURCE_MODES) || record&.source_mode || 'upload'
  end

  def apply_document_source(record)
    if record.source_mode == 'link'
      record.linked_document_url = amazon_pdf_params[:linked_document_url].presence
      record.pdf.attached?
    else
      record.linked_document_url = nil
      record.pdf.attach(amazon_pdf_params[:pdf]) if amazon_pdf_params[:pdf].present?
      false
    end
  end
end
