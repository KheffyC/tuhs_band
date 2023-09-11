# == Schema Information
#
# Table name: programs
#
#  id                     :bigint           not null, primary key
#  about_image_url        :string
#  calendar_url           :string
#  description            :string
#  detailed_description   :string
#  hero_title             :string(100)
#  image_gallery_urls     :string
#  main_gallery_image_url :string
#  name                   :string(100)      not null
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

    def to_s
        name
    end

    def slug
        name.downcase.gsub(" ", "-")
    end

    def images
      return [] unless image_gallery_urls

      image_gallery_urls.split(",")
    end
end
