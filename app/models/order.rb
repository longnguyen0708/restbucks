require 'order_state_mgr'
class Order < ApplicationRecord
  belongs_to :user
  has_one :payment, :dependent => :destroy

  validates :location, :name, :quantity, :milk, :size, :shots, :status, :cost, :user, presence: true
  validates :quantity, numericality: { only_integer: true,  greater_than: 0}
  validates :cost, numericality: {greater_than: 0}

  #before_validation :set_status_and_cost, on: [:create]

  def as_json(options = {})
    json = super(options)
    #puts json

    if json["paid_time"]
      json["paid_time"] = json["paid_time"].localtime.strftime("%c")
    end
    #puts "after paid_time #{json[:paid_time]}"
    json = json.merge(options)
    json
  end
end
