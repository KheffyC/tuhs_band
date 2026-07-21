# == Schema Information
#
# Table name: galleries
#
#  id          :bigint           not null, primary key
#  description :text
#  images      :jsonb            not null
#  title       :string           default("Gallery"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  school_id   :bigint           not null
#
# Indexes
#
#  index_galleries_on_school_id  (school_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#
class Gallery < ApplicationRecord
  belongs_to :school
  has_one_attached :image

  before_validation :normalize_images_json
  before_save :track_removed_gallery_blob_ids, if: :will_save_change_to_images?
  after_commit :purge_removed_gallery_blobs, on: :update

  validates :images, presence: true
  validates :title, presence: true

  # Return images filtered by class_period
  def images_for_period(class_period)
    return images if class_period.blank?
    images.select { |img| img["class_period"] == class_period }
  end

  # Get all unique class_periods in this gallery
  def class_periods
    images.map { |img| img["class_period"] }.compact.uniq.sort
  end

  # Safely add image to gallery
  def add_image(url, class_period = nil)
    self.images ||= []
    self.images << { "url" => url, "class_period" => class_period }
    save
  end

  # Remove image by URL
  def remove_image(url)
    self.images = images.reject { |img| img["url"] == url }
    save
  end

  private

  def normalize_images_json
    self.images = normalize_images_value(images)
  end

  def normalize_images_value(value)
    case value
    when String
      parsed = JSON.parse(value)
      parsed.is_a?(Array) ? parsed : []
    when Array
      value
    else
      []
    end
  rescue JSON::ParserError
    []
  end

  def extract_blob_signed_ids(image_value)
    normalize_images_value(image_value)
      .filter_map { |img| img.is_a?(Hash) ? img["blob_signed_id"].presence : nil }
      .uniq
  end

  def track_removed_gallery_blob_ids
    previous_images, next_images = images_change_to_be_saved
    previous_blob_ids = extract_blob_signed_ids(previous_images)
    next_blob_ids = extract_blob_signed_ids(next_images)
    @removed_blob_signed_ids = previous_blob_ids - next_blob_ids
  end

  def purge_removed_gallery_blobs
    Array(@removed_blob_signed_ids).each do |signed_id|
      begin
        blob = ActiveStorage::Blob.find_signed(signed_id)
        blob&.purge_later
      rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveRecord::RecordNotFound
        next
      end
    end

    @removed_blob_signed_ids = []
  end
end
