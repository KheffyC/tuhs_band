module ApplicationHelper
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
end
