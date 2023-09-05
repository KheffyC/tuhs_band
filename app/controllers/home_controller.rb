class HomeController < ApplicationController
  def index
    @school = School.find_by(name: 'Tulare Union')
    @programs = @school.programs.all
  end
end
