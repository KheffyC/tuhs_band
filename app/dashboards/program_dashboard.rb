require "administrate/base_dashboard"

class ProgramDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    description: Field::String,
    name: Field::String,
    short_name: Field::String,
    school: Field::BelongsTo.with_options(
      searchable: true,
      searchable_fields: ['name'],
    ),
    calendar_url: Field::String,
    year_established: Field::Date,
    main_gallery_image_url: Field::String,
    image_gallery_urls: Field::String,
    page_image_url: Field::String,
    hero_title: Field::Text,
    detailed_description: Field::Text,
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
    description
    name
    school
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    school
    name
    short_name
    hero_title
    description
    detailed_description
    year_established
    updated_at
    main_gallery_image_url
    image_gallery_urls
    calendar_url
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    school
    description
    name
    short_name
    year_established
    hero_title
    detailed_description
    main_gallery_image_url
    image_gallery_urls
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

  # Overwrite this method to customize how programs are displayed
  # across all pages of the admin dashboard.

  def display_resource(program)
    "#{program.description}"
  end
end
