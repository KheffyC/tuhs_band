require "administrate/base_dashboard"

class SchoolDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    director_name: Field::String,
    director_phone: Field::String,
    director_email: Field::String,
    percussion_director_name: Field::String,
    percussion_director_phone: Field::String,
    percussion_director_email: Field::String,
    default_image: Field::String,
    performance_absence_form: Field::String,
    rehearsal_absence_form: Field::String,
    handbook_contract_form: Field::String,
    city: Field::String,
    state: Field::String,
    district: Field::BelongsTo,
    established: Field::Date,
    about: Field::Text,
    description: Field::String,
    programs: Field::HasMany,
    hero_title: Field::Text,
    calendar_url: Field::String,
    home_page_image_urls: Field::String,
    call_to_action: Field::Text,
    contact_us: Field::Text,
    boosters: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    city
    description
    district
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    city
    state
    district
    director_name
    director_phone
    director_email
    percussion_director_name
    percussion_director_phone
    percussion_director_email
    description
    about
    hero_title
    home_page_image_urls
    default_image
    call_to_action
    contact_us
    programs
    boosters
    calendar_url
    performance_absence_form
    rehearsal_absence_form
    handbook_contract_form
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    city
    state
    district
    established
    director_name
    director_phone
    director_email
    percussion_director_name
    percussion_director_phone
    percussion_director_email
    description
    about
    hero_title
    default_image
    home_page_image_urls
    call_to_action
    contact_us
    performance_absence_form
    rehearsal_absence_form
    handbook_contract_form
    programs
    calendar_url
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how schools are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(school)
    "#{school.name}"
  end
end
