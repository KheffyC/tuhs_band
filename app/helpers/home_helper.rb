module HomeHelper
  # Returns a Google Calendar embed URL forced into AGENDA mode.
  def calendar_agenda_url(embed_url)
    return nil if embed_url.blank?

    uri = URI.parse(embed_url)
    params = URI.decode_www_form(uri.query.to_s).to_h
    uri.query = URI.encode_www_form(params.merge("mode" => "AGENDA"))
    uri.to_s
  rescue URI::InvalidURIError
    nil
  end

  # Converts a Google Calendar embed URL to a webcal:// iCal subscription URL
  # that works on both iOS (Apple Calendar) and Android (Google Calendar).
  def calendar_ical_url(embed_url)
    return nil if embed_url.blank?

    uri = URI.parse(embed_url)
    params = URI.decode_www_form(uri.query.to_s).to_h
    src = params["src"]
    return nil if src.blank?

    encoded_src = URI.encode_www_form_component(src)
    "webcal://calendar.google.com/calendar/ical/#{encoded_src}/public/basic.ics"
  rescue URI::InvalidURIError
    nil
  end
end
