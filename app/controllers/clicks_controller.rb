class ClicksController < ApplicationController
  
  def index
    post_processing
    list
    render('list')
  end
  
  def post_processing
    clicks_to_process = Click.order("clicks.id DESC").find(:all, :conditions => { :processed => false })
    clicks_to_process.each do |c|
      c.real_click        = id_real_click(c)
      c.ref_platform      = id_platform(c)
      c.ref_os            = id_user_agent_os(c)
      c.ref_browser       = id_user_agent_browser(c)
      c.ref_keyword       = id_keyword(c)
      c.processed = true
      c.save
    end
  end
  
  def id_keyword(click)
    return "null" if click.ref_url == nil
    return click.ref_url.match(/q=(.*?)&/)[1].gsub(/(%20)/," ").titleize if not click.ref_url.scan(/q=(.*?)&/).empty?
    return "n/a"
  end
  
  def id_real_click(click)
    return false if not click.ref_user_agent.scan(/Googlebot/i).empty?
    recent_clicks = Click.where("id < #{click.id}" ).order("clicks.id DESC").limit(5)
    return false if recent_clicks.detect  {|r| r["ref_ip"] == click.ref_ip }
    return true
  end
  
  def id_platform(click)
    return "null" if click.ref_user_agent == nil
    return "Googlebot" if not click.ref_user_agent.scan(/googlebot/i).empty?
    return "iPhone" if not click.ref_user_agent.scan(/iPhone/i).empty?
    return "iPad" if not click.ref_user_agent.scan(/iPad/i).empty?
    return "Android" if not click.ref_user_agent.scan(/Android/i).empty?
    return "Nokia" if not click.ref_user_agent.scan(/Nokia/i).empty?
    return "BlackBerry" if not click.ref_user_agent.scan(/BlackBerry/i).empty?
    return "Desktop"
  end
  
  def id_user_agent_os(click)
    return "null"if click.ref_user_agent == nil
    return "Googlebot" if not click.ref_user_agent.scan(/googlebot/i).empty?
    return "Windows" if not click.ref_user_agent.scan(/Windows/i).empty?
    return "OS X" if not click.ref_user_agent.scan(/os x/i).empty?
    return "Linux" if not click.ref_user_agent.scan(/linux/i).empty?
    return "Curl" if not click.ref_user_agent.scan(/curl/i).empty?
    return "ApacheBench" if not click.ref_user_agent.scan(/ApacheBench/i).empty?
  end
  
  def id_user_agent_browser(click)
    return "null" if click.ref_user_agent == nil
    return "Googlebot" if not click.ref_user_agent.scan(/googlebot/i).empty?
    return "Chrome" if not click.ref_user_agent.scan(/Chrome/i).empty?
    return "Firefox" if not click.ref_user_agent.scan(/Firefox/i).empty?
    return "Safari" if not click.ref_user_agent.scan(/Safari/i).empty?
    return "Curl" if not click.ref_user_agent.scan(/curl/i).empty?
    return "ApacheBench" if not click.ref_user_agent.scan(/ApacheBench/i).empty?
    return click.ref_browser
  end
  
  def real_clicks
    @clicks = Click.order("clicks.id DESC").limit(50).find(:all, :conditions => { :real_click => true })
    @last_click = Click.last
    render('list')
  end
  
  def list
    post_processing
    @clicks = Click.order("clicks.id DESC").limit(50)
    @last_click = Click.last
  end
  
  def got_sale
    @clicks = Click.find(params[:id])
  end
  
  def got_sale_update
    @clicks = Click.find(params[:id])
     if @clicks.update_attributes(params[:clicks])
          flash[:notice] = "Sale Recorded."
     redirect_to(:action  => 'list')
      else
        flash[:notice] = "Sale NOT Recorded."
      end    
  end
  
end
