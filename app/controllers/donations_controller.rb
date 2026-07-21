class DonationsController < ApplicationController
  before_action :ensure_donations_enabled!, only: :index

  def index
    @pricing_table_id = STRIPE_PRICING_TABLE_ID
    @publishable_key = STRIPE_PUBLISHABLE_KEY
    @buy_button_id = STRIPE_BUY_BUTTON_ID
  end

  def payment_confirmation

  end

  private

  def ensure_donations_enabled!
    redirect_to root_path unless donations_enabled?
  end
end
