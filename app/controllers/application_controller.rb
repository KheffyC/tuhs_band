class ApplicationController < ActionController::Base
  before_action :set_school
  helper_method :donations_enabled?

  # Redirect to admin dashboard after signing in with Devise
  def after_sign_in_path_for(resource)
    admin_root_path
  end

  private

  def donations_enabled?
    STRIPE_PUBLISHABLE_KEY.present? && [STRIPE_PRICING_TABLE_ID, STRIPE_BUY_BUTTON_ID].any?(&:present?)
  end

  def set_school
    @school = School.first
  end
end
