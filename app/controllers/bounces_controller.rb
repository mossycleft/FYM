class BouncesController < ApplicationController
    layout 'bounces'
  def index


  end
  
  def redirect
    @link               = Link.find(params[:id])
    @click              = Click.new
    user_agent_parser(request.env["HTTP_USER_AGENT"])
    language_parser(request.env["HTTP_ACCEPT_LANGUAGE"])
    platform_parser(request.env["HTTP_USER_AGENT"])
    @click.ref_url      = request.env["HTTP_REFERER"]
    @click.ref_ip       = request.env["REMOTE_ADDR"]
    @click.ref_domain   = request.env["HTTP_HOST"]
    @click.ref_keyword  = request.env["QUERY_STRING"]
    @link.clicks        << @click
    @click_id           = @link.clicks.last.id
  end
  def platform_parser(platform)
    if not platform.scan(/iPhone/i).empty?
      @click.ref_platform = "iPhone"
    elsif not platform.scan(/iPad/i).empty?
      @click.ref_platform = "iPad"
    elsif not platform.scan(/Android/i).empty?
      @click.ref_platform = "Android"
    elsif not platform.scan(/Android/i).empty?
      @click.ref_platform = "Android"
    else
      @click.ref_platform = "Desktop"
    end
    
  end
  
  def language_parser(language)
    if not language.scan(/en-/i).empty?
      @click.ref_language = "ENG"
    else
      @click.ref_language = language
    end    
  end
  
  def user_agent_parser(user_agent)
    if not user_agent.scan(/win/i).empty?
      @click.ref_os = "Windows"
    elsif not user_agent.scan(/os x/i).empty?
      @click.ref_os = "OS X"
    elsif not user_agent.scan(/linux/i).empty?
      @click.ref_os = "Linux"
    elsif not user_agent.scan(/Googlebot/i).empty?
      @click.ref_os = "Googlebot"
    else
      @click.ref_os = user_agent
    end
    
    if not user_agent.scan(/Chrome/i).empty?
      @click.ref_browser = "Chrome"
    elsif not user_agent.scan(/Firefox/i).empty?
      @click.ref_browser = "Firefox"
    elsif not user_agent.scan(/Safari/i).empty?
      @click.ref_browser = "Safari"
    else
      @click.ref_os = user_agent 
    end
  end
end
