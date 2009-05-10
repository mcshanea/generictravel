class JavascriptsController < ApplicationController
  # javascripts_controller.rb
  def dynamic_hotels
    @hotels = Hotel.find(:all)
  end
end
