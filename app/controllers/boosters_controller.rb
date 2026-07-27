class BoostersController < ApplicationController
  before_action :require_feature_enabled!

  def index
    @staff_members = StaffMember.where(school: @school).ordered.with_attached_photo
    @boosters = Booster.where(school: @school).order(:created_at)
    @active_tab = "boosters"
    render "staff_members/index"
  end

  private

  def require_feature_enabled!
    render file: "#{Rails.root}/public/404.html", status: :not_found unless @school&.boosters_enabled?
  end
end

