class BouncesController < ApplicationController
    layout 'bounces'
  def index
    redirect
    render('redirect')
  end
  
  def redirect
    uuid                    = UUID.new
    @click_uuid             = uuid.generate
    @link                   = Link.find(params[:id])
    Click.create(:link_id => params[:id], :click_uuid => @click_uuid, :ref_url => request.env["HTTP_REFERER"], :ref_user_agent => request.env["HTTP_USER_AGENT"], :ref_ip => request.env["REMOTE_ADDR"])
  end
end

