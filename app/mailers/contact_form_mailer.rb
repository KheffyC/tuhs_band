class ContactFormMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def message_email(director_email:,params:)
    @params = params
    mail(from: params[:email_address],
         to: 'kheffy.cervantez@gmail.com',
         subject: "#{params[:name]} - #{params[:subject]}")
  end
end
