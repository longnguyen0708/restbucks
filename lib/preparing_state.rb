require 'state'
class PreparingState < State
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
    @order_state_mgr.state = @order_state_mgr.ready_state #change to ready state
    puts "PreparingState.barista_done_preparing change state from preparing to ready"
    true
  end

  def complete_order
    @order_state_mgr.state = @order_state_mgr.completed_state
    puts "PreparingState.complete_order change state from preparing to completed"
    true
  end

  def hypermedia
  #  puts "PreparingState.hypermedia " + @order_state_mgr.controller.url_for(:only_path => false, :controller => 'receipts') + "/#{@order_state_mgr.order_id}"
  #  {'receipts' => @order_state_mgr.controller.url_for(:only_path => false, :controller => 'receipts') + "/#{@order_state_mgr.order_id}"}
    {}
  end

  def get_str
    'Preparing'
  end
end