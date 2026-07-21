class HomeController < ApplicationController
  def index
    @programs = @school ? @school.programs : Program.none
  end

  def about
    @programs = @school ? @school.programs : Program.none
  end
end
