class BouncesController < ApplicationController
    layout 'bounces'
  def index
    redirect
    render('redirect')
  end
  
  def redirect
    uuid                    = UUID.new
    @click_uuid             = uuid.generate
    @ref_url                = request.env["HTTP_REFERER"]
    @ref_user_agent         = request.env["HTTP_USER_AGENT"]
    @ref_ip                 = request.env["REMOTE_ADDR"]
    save_referal_info(params[:id])

  end
  
  def save_referal_info(link_id_from_params)
    @link                   = Link.find(link_id_from_params)
    @click                  = Click.new
    @click.click_uuid       = @click_uuid
    @click.ref_url          = @ref_url
    @click.ref_user_agent   = @ref_user_agent
    @click.ref_ip           = @ref_ip
    @click.link_id          = link_id_from_params
    @click.save
    # @link.clicks            << @click
  end
  
end
