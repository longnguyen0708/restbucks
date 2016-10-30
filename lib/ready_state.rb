require 'state'
class ReadyState < State
  def initialize(order_state_mgr)
    @order_state_mgr = order_state_mgr
  end

  def update_order
    false
  end

  def cancel_order
    false
  end

  def payment
    false
  end

  def barista_done_preparing
    false
  end

  def complete_order
    @order_state_mgr.state = @order_state_mgr.completed_state
    puts "ReadyState.complete_order change state from ready to completed"
    true
  end

  def hypermedia
    puts "ReadyState.hypermedia " + @order_state_mgr.controller.url_for(:only_path => false, :controller => 'receipts') + "/#{@order_state_mgr.order_id}"
    {'receipts' => @order_state_mgr.controller.url_for(:only_path => false, :controller => 'receipts') + "/#{@order_state_mgr.order_id}"}
  end

  def get_str
    'ready'
  end
end