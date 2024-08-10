# == Schema Information
#
# Table name: programs
#
#  id                     :bigint           not null, primary key
#  about_image_url        :string
#  calendar_url           :string
#  circuit                :string(50)
#  description            :string
#  detailed_description   :string
#  hero_title             :string(100)
#  ig_handle              :string(50)
#  image_gallery_urls     :string
#  main_gallery_image_url :string
#  name                   :string(100)      not null
#  period                 :integer          default(0)
#  short_name             :string
#  year_established       :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  school_id              :bigint           not null
#
# Indexes
#
#  index_programs_on_name       (name)
#  index_programs_on_school_id  (school_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#
class Program < ApplicationRecord
    belongs_to :school
    has_many :amazon_pdfs
    has_many :sections, dependent: :destroy, class_name: 'PracticeHub::Section'
    has_many :collections, through: :sections, class_name: 'PracticeHub::Collection'

    def to_s
        short_name
    end

    def slug
        name.downcase.gsub(" ", "-")
    end

    def images
      return [] unless image_gallery_urls

      image_gallery_urls.split(",")
    end
end
