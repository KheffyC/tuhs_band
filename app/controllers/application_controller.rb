class ApplicationController < ActionController::Base
  before_action :set_school

  private

  def set_school
    @school = School.first
  end
end
