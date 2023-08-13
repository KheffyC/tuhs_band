class HomeController < ApplicationController
  def index
    @programs = School.find_by(name: 'Tulare Union').programs.all
  end
end
