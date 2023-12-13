class DonationsController < ApplicationController
  def index
    @pricing_table_id = STRIPE_PRICING_TABLE_ID
    @publishable_key = STRIPE_PUBLISHABLE_KEY
  end

  def payment_confirmation

  end
end
