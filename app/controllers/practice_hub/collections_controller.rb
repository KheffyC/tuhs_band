module PracticeHub
  class CollectionsController < PracticeHub::ApplicationController
    before_action :set_program

    def show
      @collection = @program.collections.find(params[:id])
    end

    private

    def set_program
      @program = @school.programs.find(params[:program_id])
    end
  end
end
