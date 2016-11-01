require 'cost_decorator'

class Size < CostDecorator
  attr_accessor :option
  def initialize(component)
    super(component)
  end

  def cal
    super + price
  end

  def price
    case @option
      when "Small"
        0.5
      when "Medium"
        0.75
      when "Large"
        1
      else
        0
    end
  end

  def set_option(op)
    @option = op
  end

end