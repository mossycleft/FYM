class BouncesController < ApplicationController
    layout 'bounces'
  def index
    redirect
    render('redirect')

  end
  
  def redirect
    @link               = Link.find(params[:id])
    @click              = Click.new
    @click.ref_os       = request.env["HTTP_USER_AGENT"]
    @click.ref_browser  = request.env["HTTP_USER_AGENT"]
    @click.ref_language = request.env["HTTP_ACCEPT_LANGUAGE"]
    @click.ref_platform = request.env["HTTP_USER_AGENT"]
    @click.ref_url      = request.env["HTTP_REFERER"]
    @click.ref_ip       = request.env["REMOTE_ADDR"]
    @click.ref_domain   = request.env["HTTP_HOST"]
    @click.ref_keyword  = request.env["QUERY_STRING"]
    @link.clicks        << @click
    @click_id           = @click.id

  end
  
end
