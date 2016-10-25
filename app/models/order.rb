require 'order_state_mgr'
class Order < ApplicationRecord
  belongs_to :user
  has_one :payment, :dependent => :destroy

  validates :location, :name, :quantity, :milk, :size, :shots, :status, :cost, :user, presence: true
  validates :quantity, numericality: { only_integer: true,  greater_than: 0}
  validates :cost, numericality: {greater_than: 0}

  #before_validation :set_status_and_cost, on: [:create]

  def error_msg
    return errors.full_messages[0]
  end

  # def set_status_and_cost
  #   self.status = "payment expected"
  #   self.cost = 2
  # end

  def as_json(options = {})
    json = super(options)
    #if (options[:payment_link])
     # json['payment'] = options[:payment_link]
    #end
    #if (options[:receipt_link])
    #  json['receipt'] = options[:receipt_link]
    #end
    json = json.merge(options)
    json
  end
end
