require 'cost_decorator'

class Milk < CostDecorator
  attr_accessor :option
  def initialize(component)
    super(component)
  end

  def cal
    super + price
  end

  def price
    case @option
      when "Skim"
        0.5
      when "Semi"
        0.75
      when "Whole"
        1
      else
        0
    end
  end

  def set_option(op)
    @option = op
  end

end