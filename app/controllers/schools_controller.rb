class SchoolsController < ApplicationController
  before_action :set_school

  def show; end

  private

  def set_school
    @school = School.find(1)
  end


end
