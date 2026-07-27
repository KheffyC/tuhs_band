class GalleriesController < ApplicationController
  before_action :require_feature_enabled!
  before_action :set_gallery, only: [:show]

  def index
    @galleries = Gallery.all.order(:created_at)
  end

  def show
    @class_periods = @gallery.class_periods
    @selected_period = params[:period]
    @images = @selected_period.present? ? @gallery.images_for_period(@selected_period) : @gallery.images
  end

  private

  def require_feature_enabled!
    render file: "#{Rails.root}/public/404.html", status: :not_found unless @school&.photo_gallery_enabled?
  end

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
end
