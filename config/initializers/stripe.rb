stripe_credentials = Rails.application.credentials.stripe || {}

STRIPE_PUBLISHABLE_KEY = stripe_credentials[:publishable_key].presence || ENV["STRIPE_PK"].presence
STRIPE_PRICING_TABLE_ID = stripe_credentials[:pricing_table_id].presence || ENV["STRIPE_PID"].presence
STRIPE_BUY_BUTTON_ID = stripe_credentials[:buy_button_id].presence || ENV["STRIPE_BID"].presence
