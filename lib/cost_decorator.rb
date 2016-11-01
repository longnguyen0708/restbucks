require 'payment_expected_state'
require 'preparing_state'
require 'ready_state'
require 'completed_state'

class CostDecorator
  def initialize(component)
    @component = component
  end

  def cal
    @component.cal
  end
end