class AmazonPdfsController < ApplicationController
  before_action :authenticate_director!, only: [:new, :create]
  before_action :set_amazon_pdf , only: [:show, :edit, :update, :destroy]

  def index
    @programs = @school.programs.order(:short_name, :name)
    @selected_program_id = params[:program_id].presence
    @selected_program = @programs.find_by(id: @selected_program_id)
    @amazon_pdfs = AmazonPdf.library_documents.includes(:program).order(type_of_pdf_group: :desc)
    group_order = ['Itinerary','Schedules', 'Syllabus']
    @selected_group = params[:group].presence

    if @selected_group.present?
      @amazon_pdfs = @amazon_pdfs.where(type_of_pdf_group: @selected_group)
    end

    if @selected_program.present?
      @amazon_pdfs = @amazon_pdfs.where(program_id: @selected_program.id)
    end

    @grouped_amazon_pdfs = @amazon_pdfs.order(:event_date).group_by { |pdf| pdf.type_of_pdf_group }
    @ordered_pdfs = @grouped_amazon_pdfs.sort_by { |group_name, pdfs| group_order.index(group_name) || 999 }
  end

  def student_forms
    @amazon_pdfs = AmazonPdf.student_forms.order(name: :desc)
  end

  def new
    @amazon_pdfs = AmazonPdf.all
    @amazon_pdf = AmazonPdf.new
    # When a program page links here, keep that program preselected for faster uploads.
    @amazon_pdf.program_id = params[:program_id] if params[:program_id].present?
  end

  def edit; end

  def update
    if @amazon_pdf
      @amazon_pdf.update(amazon_pdf_params)
      flash[:notice] = "PDF was successfully updated."
    else
      flash[:alert] = "PDF could not be updated."
    end

    redirect_to action: :index
  end

  def create
    ap amazon_pdf_params
    @amazon_pdf = AmazonPdf.new.tap do |amazon_pdf|
      amazon_pdf.name = amazon_pdf_params[:name]
      amazon_pdf.type_of_pdf_group = amazon_pdf_params[:type_of_pdf_group]
      amazon_pdf.pdf.attach(amazon_pdf_params[:pdf])
      amazon_pdf.program = Program.find(amazon_pdf_params[:program_id]) if amazon_pdf_params[:program_id].present?
      amazon_pdf.director = current_director
      amazon_pdf.event_date = amazon_pdf_params[:event_date] if amazon_pdf_params[:event_date].present?
    end

    if @amazon_pdf.save
      # Program-page inline uploads send a return_to path; the regular PDFs page falls back here.
      redirect_path = amazon_pdf_params[:return_to].presence
      target_path = redirect_path&.start_with?('/') ? redirect_path : amazon_pdfs_path
      redirect_to(target_path, notice: "PDF uploaded successfully.")
    else
      @amazon_pdf.errors.full_messages.each do |message|
        flash[:alert] = message
      end
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
    params.require(:amazon_pdf).permit!
  end
end
