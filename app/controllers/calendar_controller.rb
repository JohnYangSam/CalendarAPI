class CalendarController < ApplicationController
  # create embed => embed => popup
  
  def popup
    opts = get_params 

    @title = opts[:tt]
    @url = googlecalendar_url opts
    @datestring = Time.new(opts[:sy],opts[:sm], opts[:sd]).strftime("5:00pm, %A, %B %C, %Y ")
    
    render layout: false
  end
  
  def embed 
    opts = get_params
    
    @url = popup_url opts
  end
  
  def googlecalendar
    sy = params[:sy].to_i
    sm = params[:sm].to_i
    sd = params[:sd]
    st = params[:st]
    sz = params[:sz] if params[:sz] =~ /[+-]\d{2}:\d{2}/
    
    ey = params[:ey]
    em = params[:em]
    ed = params[:ed]
    et = params[:et]
    ez = params[:ez]
    
    if !st.blank? && st =~ /\d{0,2}[:.]\d{2}/
      st = st.scan /\d+/
      sh = st.first.to_i + (st.include?('p') ? 12 : 0)
      sm = st.last.to_i
      Time.new(sy, sm, sd, sh, sm, nil, sz)
      date = Time.now.getutc.strftime('%Y%m%d')
    else
      Time.new(sy, sm, sd, nil, nil, nil, sz)
      date = Time.now.getutc.strftime('%Y%m%d')
    end
    
    # e.g. 20060415T180000Z
    date = Time.now.getutc.strftime('%Y%m%d')

    if !ey.blank?
      date += "/#{Time.now.getutc.strftime('%Y%m%d')}"
    else
      date += "/#{date}"
    end
    
    options = {
      action:  'TEMPLATE',
      text:    params[:tt] || "New Event",
      dates:   date,
      sprop:   'foo'
    }
    
    opt = options.collect {|k,v| "#{CGI.escape k.to_s}=#{CGI.escape v}"}.join '&'
    # render :text => options.inspect
    redirect_to "http://www.google.com/calendar/event?" + opt
  end

  private
  # reads params into a hash


end
