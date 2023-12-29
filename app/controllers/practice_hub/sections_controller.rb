module PracticeHub
  class SectionsController < PracticeHub::ApplicationController
    before_action :set_program
    before_action :set_section, only: [:show, :edit, :update, :destroy, :new_collection, :create_collection]
    invisible_captcha only: [:create]

    def index
      @sections = @program.sections.all
    end

    def show; end

    def new
      @section = @program.sections.new
    end

    def create
      @section = @program.sections.new(section_params)

      if @section.save
        redirect_to practice_hub_program_sections_path(@program)
      else
        @section.errors.full_messages.each do |message|
          flash[:alert] = message
        end
        render :new
      end
    end

    def new_collection
      @collection = @section.collections.new
    end

    def create_collection
      @collection = @section.collections.new(collection_params)

      if @collection.save
        redirect_to practice_hub_program_section_path(@program, @section)
      else
        @collection.errors.full_messages.each do |message|
          flash[:alert] = message
        end
        render :new_collection
      end
    end

    private

    def set_section
      @section = @program.sections.find(params[:id])
    end

    def section_params
      params.require(:practice_hub_section).permit(:name, :instrument)
    end

    def collection_params
      params.require(:practice_hub_collection).permit(:title)
    end

    def set_program
      @program = Program.find(params[:program_id])
    end
  end
end
