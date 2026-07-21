require "administrate/base_dashboard"

class FundraiserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    goal: Field::String,
    call_to_action: Field::String,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    program: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    program
    start_date
    end_date
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    title
    program
    description
    goal
    call_to_action
    start_date
    end_date
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    title
    program
    description
    goal
    call_to_action
    start_date
    end_date
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(fundraiser)
    fundraiser.title.to_s
  end
end
