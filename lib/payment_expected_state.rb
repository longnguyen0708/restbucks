require 'state'
class PaymentExpectedState < State
  def initialize(order_state_mgr)
    @order_state_mgr = order_state_mgr
  end

  def update_order
    true
  end

  def cancel_order
    true
  end

  def payment
    @order_state_mgr.state = @order_state_mgr.preparing #change to ready state
    puts "PaymentExpectedState.payment change state from PaymentExpectedState to Preparing"
    true
  end

  def barista_done_preparing
    false
  end

  def complete_order
    false
  end

  def hypermedia
    puts "PaymentExpectedState.hypermedia " + @order_state_mgr.controller.url_for(:only_path => false, :controller => 'payments') + "/#{@order_state_mgr.order_id}"
    {'payment' => @order_state_mgr.controller.url_for(:only_path => false, :controller => 'payments') + "/#{@order_state_mgr.order_id}"}
  end

  def get_str
    'Payment expected'
  end
end