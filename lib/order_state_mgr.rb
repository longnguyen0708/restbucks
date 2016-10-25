require 'payment_expected_state'
require 'preparing_state'
require 'ready_state'
require 'completed_state'

class OrderStateMgr
  attr_accessor :controller, :order_id, :payment_expected_state, :preparing, :ready_state, :completed_state, :state
  def initialize(controller)
    @controller = controller
    @payment_expected_state = PaymentExpectedState.new(self)
    @preparing = PreparingState.new(self)
    @ready_state = ReadyState.new(self)
    @completed_state = CompletedState.new(self)

    @state = @payment_expected_state
  end

  def self.instance(controller)
      @@instant ||= OrderStateMgr.new(controller)
    @@instant
  end

  def set_curr_state(order)
    @order_id = order.id

    case order.status
      when @preparing.get_str
        @state = @preparing
      when @ready_state.get_str
        @state = @ready_state
      when @completed_state.get_str
        @state = @completed_state
      else
        @state = @payment_expected_state
    end
    puts "set_curr_state: #{@state.get_str}"
  end

  def update_order
    @state.update_order
  end

  def cancel_order
    @state.cancel_order
  end

  def payment
    @state.payment
  end

  def barista_done_preparing
    @state.barista_done_preparing
  end

  def complete_order
    @state.complete_order
  end

  def hypermedia
    puts "OrderStateMgr.hypermedia: #{@state.get_str}"
    @state.hypermedia
  end

  def get_state_str
    @state.get_str
  end
end