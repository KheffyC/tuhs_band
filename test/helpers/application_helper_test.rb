require "test_helper"

class ApplicationHelperTest < ActiveSupport::TestCase
  test "local image asset names are discovered recursively" do
    view = helper_context
    image_names = view.local_image_asset_names

    assert_includes image_names, "logo.png"
    assert image_names.all? { |name| name.match?(%r{\A[\w./-]+\.(png|jpg|jpeg|webp|gif|svg)\z}i) }
  end

  test "safe image source resolves local image filenames" do
    resolved = helper_context.safe_image_source("logo.png")

    assert_match %r{logo\.png\z}, resolved
  end

  private

  def helper_context
    context_class = Class.new do
      include ApplicationHelper

      def image_path(path)
        "/assets/#{path}"
      end
    end

    @helper_context ||= context_class.new
  end
end