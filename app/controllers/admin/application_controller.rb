# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_director!
    helper_method :donations_enabled?
    
    # Use custom admin layout with modern design
    layout "admin"

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    private

    def donations_enabled?
      STRIPE_PUBLISHABLE_KEY.present? && [STRIPE_PRICING_TABLE_ID, STRIPE_BUY_BUTTON_ID].any?(&:present?)
    end
  end
end
