class GalleriesController < ApplicationController
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

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
end
