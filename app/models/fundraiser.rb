# == Schema Information
#
# Table name: fundraisers
#
#  id             :bigint           not null, primary key
#  call_to_action :string
#  description    :string
#  end_date       :datetime
#  goal           :string
#  main_image     :string
#  start_date     :datetime
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  program_id     :bigint           not null
#
# Indexes
#
#  index_fundraisers_on_program_id  (program_id)
#
# Foreign Keys
#
#  fk_rails_...  (program_id => programs.id)
#
class Fundraiser < ApplicationRecord
  belongs_to :program

  has_one_attached :flyer

  validates :title, presence: true
  validates :program, presence: true

  validate :flyer_content_type

  scope :active, -> { where('end_date IS NULL OR end_date >= ?', Time.current).order(start_date: :desc) }
  scope :past,   -> { where('end_date < ?', Time.current).order(end_date: :desc) }

  def active?
    end_date.nil? || end_date >= Time.current
  end

  def flyer_url
    return Rails.application.routes.url_helpers.rails_blob_url(flyer, only_path: true) if flyer.attached?
    main_image.presence
  end

  def to_s
    title
  end

  private

  def flyer_content_type
    return unless flyer.attached?

    unless flyer.content_type.in?(%w[image/png image/jpeg image/jpg image/webp image/gif])
      errors.add(:flyer, 'must be a PNG, JPG, WEBP, or GIF image')
    end
  end
end
