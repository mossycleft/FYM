class BouncesController < ApplicationController
  after_filter :save_click
  layout 'bounces'
  def index
    redirect
    render('redirect')
  end
  
  def redirect
    uuid                    = UUID.new
    @click_uuid             = uuid.generate
    @link                   = Link.find(params[:id])
    @ref_url                = request.env["HTTP_REFERER"]
    @ref_ip                 = request.env["REMOTE_ADDR"]
    @ref_user_agent         = request.env["HTTP_USER_AGENT"]
  end
  
  private
  
  def save_click
    Click.create(:link_id => params[:id], :click_uuid => @click_uuid, :ref_url => @ref_url, :ref_user_agent => @ref_user_agent, :ref_ip => @ref_ip)
    
  end
end

