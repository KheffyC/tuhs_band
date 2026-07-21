ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...

  private

  def with_stripe_config(publishable_key:, pricing_table_id: nil, buy_button_id: nil)
    original_constants = {
      STRIPE_PUBLISHABLE_KEY: STRIPE_PUBLISHABLE_KEY,
      STRIPE_PRICING_TABLE_ID: STRIPE_PRICING_TABLE_ID,
      STRIPE_BUY_BUTTON_ID: STRIPE_BUY_BUTTON_ID
    }

    replace_global_constant(:STRIPE_PUBLISHABLE_KEY, publishable_key)
    replace_global_constant(:STRIPE_PRICING_TABLE_ID, pricing_table_id)
    replace_global_constant(:STRIPE_BUY_BUTTON_ID, buy_button_id)

    yield
  ensure
    original_constants.each do |constant_name, value|
      replace_global_constant(constant_name, value)
    end
  end

  def replace_global_constant(constant_name, value)
    Object.send(:remove_const, constant_name) if Object.const_defined?(constant_name)
    Object.const_set(constant_name, value)
  end
end
