require 'cost_decorator'

class Shots < CostDecorator
  attr_accessor :option
  def initialize(component)
    super(component)
  end

  def cal
    super + price
  end

  def price
    case @option
      when "Single"
        0.5
      when "Double"
        0.75
      when "Triple"
        1
      else
        0
    end
  end

  def set_option(op)
    @option = op
  end

end