module ApplicationHelper
  LOCAL_IMAGE_EXTENSIONS = %w[png jpg jpeg webp gif svg].freeze

  def safe_image_source(*sources, fallback: 'logo.png')
    Array(sources).flatten.compact.each do |source|
      normalized_source = source.to_s.strip
      next if normalized_source.blank?

      return normalized_source if normalized_source.match?(%r{\A(?:https?:)?//}i) || normalized_source.start_with?('data:')

      return image_path(normalized_source)
    rescue StandardError
      next
    end

    image_path(fallback)
  rescue StandardError
    fallback
  end

  def local_image_asset_names
    cache_key = [
      'local_image_asset_names',
      Rails.root.join('app/assets/images').to_s,
      Dir.glob(Rails.root.join('app/assets/images/**/*.{png,jpg,jpeg,webp,gif,svg}')).map { |path| File.mtime(path).to_i }.max.to_i
    ]

    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      Dir.glob(Rails.root.join('app/assets/images/**/*.{png,jpg,jpeg,webp,gif,svg}')).map do |path|
        Pathname.new(path).relative_path_from(Rails.root.join('app/assets/images')).to_s
      end.sort
    end
  end

  def admin_image_field_name?(attribute_name)
    attribute_name.to_s.match?(/image|gallery/i)
  end
end
