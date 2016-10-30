class ReceiptsController < ApplicationController
  before_action :authenticate_user_from_token
  def index
    render status: :not_found
  end
  # DELETE /receipts/1
  def complete
    @order = Order.find(params[:id])
    OrderStateMgr.instance(self).set_curr_state(@order)
    if OrderStateMgr.instance(self).complete_order
      @order.update({:status => OrderStateMgr.instance(self).get_state_str})
      render status: :no_content
    else
      render status: :method_not_allowed
    end

  end
end
