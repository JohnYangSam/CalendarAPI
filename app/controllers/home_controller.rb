class HomeController < ApplicationController
  def index
    current_time = Time.new();
    @current_year = current_time.year
  end

  def generate
    sy = params[:start_year] || Time.now.year
    sm = params[:start_month] || Time.now.month
    sd = params[:start_day] || Time.now.day
    st = params[:start_time]
    sz = params[:sz] if params[:sz] =~ /[+-]\d{2}:\d{2}/

    ey = params[:ey]
    em = params[:em]
    ed = params[:ed]
    et = params[:et]
    ez = params[:ez]

    @opts = {
      :sy => sy,
      :sm => sm,
      :sd => sd,
      :st => st,
      :sz => sz,
      :ey => params[:ey],
      :em => params[:em],
      :ed => params[:ed],
      :et => params[:et],
      :ez => params[:ez],
      :tt => params[:event_name] || "My Event"
    }
  end
end
