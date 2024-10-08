module PracticeHub
  class CollectionsController < PracticeHub::ApplicationController
    before_action :set_program
    before_action :set_collection, only: [:show, :new_music, :create_music, :view_music, :destroy_music]

    def show
    end

    def new_music
      @music = @collection.music_sheets.new
      puts 'working'
    end

    def create_music
      @music = @collection.music_sheets.new(music_params)
      flat_file_link = music_params[:flat_file_link]

      if flat_file_link.present?
        flat_file_link.gsub!('https://flat.io/score/', 'https://flat.io/embed/')
        flat_file_link.gsub!('?', "?appId=#{ENV['FLAT_APP_ID']}&")
        @music.flat_file_link = flat_file_link
      end

      if @music.save
        redirect_to action: :show
      else
        render :new_music
      end
    end

    def view_music
      @sheet = @collection.music_sheets.find(params[:sheet_id])
    end

    def destroy_music
      @sheet = @collection.music_sheets.find(params[:sheet_id])
      @sheet.destroy if @sheet.present?

      flash[:notice] = 'Music Sheet Deleted' if @sheet.destroyed?
      redirect_to action: :show
    end


    private

    def music_params
      params.fetch(:practice_hub_music_sheet, {}).permit(:title, :description, :flat_file_link, :s3_link, :flat_file_id)
    end

    def set_program
      @program = @school.programs.find(params[:program_id])
    end

    def set_collection
      @collection = @program.collections.find(params[:id])
    end
  end
end
