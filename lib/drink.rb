require 'cost_decorator'

class Drink < CostDecorator
  attr_accessor :option
  def initialize(component)
    super(component)
  end

  def cal
    super + price
  end

  def price
    puts 'drink price'
    case @option
      when "Latte"
        2.5
      when "Cappuccino"
        3
      when "Mocha"
        2.5
      when "Macchiato"
        2
      when "Espresso"
        3
      when "Americano"
        2
      else
        0
    end
  end

  def set_option(op)
    @option = op
  end

end