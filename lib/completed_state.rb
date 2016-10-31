require 'state'
class CompletedState < State
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
    false
  end

  def hypermedia
    {}
  end

  def get_str
    'Completed'
  end
end