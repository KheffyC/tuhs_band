class AmazonPdfsController < ApplicationController
  before_action :authenticate_director!, only: [:new, :create]
  before_action :set_amazon_pdf , only: [:show, :edit, :update, :destroy]

  def index
    @amazon_pdfs = AmazonPdf.all
  end

  def new
    @amazon_pdfs = AmazonPdf.all
    @amazon_pdf = AmazonPdf.new
  end

  def create
    @amazon_pdf = AmazonPdf.new.tap do |amazon_pdf|
      amazon_pdf.name = amazon_pdf_params[:name]
      amazon_pdf.pdf.attach(amazon_pdf_params[:pdf])
    end

    if @amazon_pdf.save
      redirect_to amazon_pdfs_path
    else
      @amazon_pdf.errors.full_messages.each do |message|
        flash[:alert] = message
      end
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_amazon_pdf
    @amazon_pdf = AmazonPdf.find(params[:id])
  end

  def amazon_pdf_params
    params.require(:amazon_pdf).permit!
  end
end
