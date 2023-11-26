class ContactsController < ApplicationController
  before_action :set_boosters
  invisible_captcha only: [:create]

  def index; end

  def show; end

  def create
    return unless @school.director_email.present? && @school.director_name.present? && @school.director_phone.present?

    if contact_params[:name].blank? || contact_params[:email_address].blank? || contact_params[:message].blank?
      flash[:alert] = 'Please fill out all fields'
      redirect_to contacts_path
    else
      ContactFormMailer.message_email(director_email: @school.director_email, params: contact_params).deliver_later
      flash[:notice] = 'Message sent'
      redirect_to home_index_path
    end
  end

  private

  def set_boosters
    @boosters = Booster.all
  end

  def contact_params
    params.require(:contact).permit(:name, :email_address, :message, :subject)
  end
end
