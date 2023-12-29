module PracticeHub
  class ApplicationController < ApplicationController
    before_action :authenticate_director!
  end
end
