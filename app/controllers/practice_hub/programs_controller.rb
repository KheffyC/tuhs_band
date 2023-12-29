module PracticeHub
  class ProgramsController < PracticeHub::ApplicationController
    before_action :authenticate_director!
    before_action :set_program, only: [:show, :edit, :update, :destroy]

    def index
      @programs = School.first.programs
    end
  end
end
