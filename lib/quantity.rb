require 'cost_decorator'

class Quantity < CostDecorator
  attr_accessor :option
  def initialize(component)
    super(component)
  end

  def cal
    super * price
  end

  def price
    @option.to_i
  end

  def set_option(op)
    @option = op
  end

end