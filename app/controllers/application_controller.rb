class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def get_params
    opts = {
      :sy => params[:sy],
      :sm => params[:sm],
    }
    
    [:sd, :st, :sz, :ey, :em, :ed, :et, :ez].each do |k|
      next if [:sz, :ez].include?(k) && !(params[k] =~ /[+-]\d{2}:\d{2}/)
      if params[k]
        opts[k] = params[:k]
      end
    end
    
    # default title
    opts[:tt] = params[:tt] || "My Event"
    
    opts
  end
end
