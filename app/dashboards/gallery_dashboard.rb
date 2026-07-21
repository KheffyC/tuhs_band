require "administrate/base_dashboard"

class GalleryDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    school: Field::BelongsTo,
    title: Field::String,
    description: Field::Text,
    images: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    school
    title
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    school
    title
    description
    images
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    school
    title
    description
    images
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(gallery)
    "#{gallery.school.name} - #{gallery.title}"
  end
end
