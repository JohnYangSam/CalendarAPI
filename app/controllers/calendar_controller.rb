class CalendarController < ApplicationController
  # create embed => embed => popup
  
  def popup
    opts = get_params 

    @title = opts[:tt]
    @url = googlecalendar_url opts
    @datestring = Time.new(opts[:sy],opts[:sm], opts[:sd]).strftime("%A, %B %d, %Y ")
    
    @datestring = params[:st] + ", "+ @datestring if params[:st]
      
    
    render layout: false
  end
  
  def embed 
    opts = get_params
    @url = popup_url(opts)
  end
  
  # http://www.google.com/googlecalendar/event_publisher_guide_detail.html
  def googlecalendar
    sy = params[:sy].to_i
    sm = params[:sm].to_i
    sd = params[:sd]
    st = params[:st]
    sz = params[:sz] =~ /[+-]\d{2}:\d{2}/ ? params[:sz] : Time.now.strftime("%:z")
    
    ey = params[:ey]
    em = params[:em]
    ed = params[:ed]
    et = params[:et]
    ez = params[:ez]
    
    
    # e.g. 20060415T180000Z
    if !st.blank? && st =~ /\d{0,2}[:.]\d{2}/
      sta = st.scan /\d+/
      sth = sta.first.to_i + (st.include?('p') ? 12 : 0)
      stm = sta.last.to_i
      
      # timezones are kinda messed up when crossing dst
      date = Time.new(sy, sm, sd, sth, stm, nil, sz).getutc.strftime('%Y%m%dT%H%M%SZ')
    else
      date = Time.new(sy, sm, sd, nil, nil, nil, sz).getutc.strftime('%Y%m%d')
    end

    # if !ey.blank?
      # date += "/#{Time.now.getutc.strftime('%Y%m%d')}"
    # else
      date += "/#{date}"
    # end
    
    options = {
      action:  'TEMPLATE',
      text:    params[:tt] || "New Event",
      dates:   date
    }
    
    opt = options.collect {|k,v| "#{CGI.escape k.to_s}=#{CGI.escape v}"}.join '&'
    # render :text => options.inspect and return
    redirect_to "http://www.google.com/calendar/event?" + opt
  end

  private
  # reads params into a hash


end
