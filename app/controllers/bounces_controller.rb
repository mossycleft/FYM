class BouncesController < ApplicationController
  
  layout 'bounces'
  caches_action :pull_link, :expires_in  => 7.days
  
  def index
    redirect
    render('redirect')
  end
  
  def redirect
    uuid                    = UUID.new
    @click_uuid             = uuid.generate
    pull_link(params[:id])
    save_click( params[:id],
                @click_uuid, 
                request.env["HTTP_REFERER"],
                request.env["HTTP_USER_AGENT"], 
                request.env["REMOTE_ADDR"]
                )    
  end
  
  def pull_link(link_id)
    @link = Link.find(link_id)
    @link.affiliate.remarketing_code
  end
  
  def save_click(link_id, click_uuid, ref_url, ref_user_agent, ref_ip)
    $redis.hmset( "click:#{@click_uuid}",
                  "link_id", link_id,
                  "click_uuid", click_uuid,
                  "ref_url", ref_url,
                  "ref_user_agent", ref_user_agent,
                  "ref_ip", ref_ip
                )
  end
  

      
    # Click.create(:link_id => params[:id], :click_uuid => @click_uuid, :ref_url => @ref_url, :ref_user_agent => @ref_user_agent, :ref_ip => @ref_ip)
  
end

