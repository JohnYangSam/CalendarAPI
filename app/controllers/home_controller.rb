class HomeController < ApplicationController
  def index
    current_time = Time.new();
    @current_year = current_time.year
  end
end
