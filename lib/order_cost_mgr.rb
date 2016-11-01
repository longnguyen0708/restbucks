require 'cost_decorator'
require 'bill_end'
require 'drink'
require 'milk'
require 'quantity'
require 'shots'
require 'size'


class OrderCostMgr
  def initialize
    @bill_end = BillEnd.new
    @drink = Drink.new(@bill_end)
    @milk = Milk.new(@drink)
    @shots = Shots.new(@milk)
    @size = Size.new(@shots)
    @quantity = Quantity.new(@size)
  end

  def self.instance
    @@instant ||= OrderCostMgr.new
    @@instant
  end

  def set_drink(drink)
    @drink.set_option(drink)
  end

  def set_milk(milk)
    @milk.set_option(milk)
  end

  def set_shots(shots)
    @shots.set_option(shots)
  end

  def set_size(size)
    @size.set_option(size)
  end

  def set_quantity(quantity)
    @quantity.set_option(quantity)
  end

  def calculate_cost
    @quantity.cal
  end

end