class ClicksController < ApplicationController
  
  def index
    list
    render('list')
  end
  
  def list
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
