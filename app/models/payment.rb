class Payment < ApplicationRecord
  belongs_to :order

  validates :order, presence: true, on: :create

  validates :card_holder_name, :order, presence: true, on: :update
  validates :card_number, numericality: { only_integer: true }, on: :update
  validates :card_number, length: { is: 16 }, on: :update
  validates :expiry_month, numericality: { only_integer: true,  greater_than: 0, less_than_or_equal_to: 12}, on: :update
  validates :expiry_year, numericality: { only_integer: true,  greater_than: 2015, less_than_or_equal_to: 2100}, on: :update
  validates :amount, numericality: {greater_than: 0}, on: :update

  def as_json(options = {})
    json = super(options)
    json = json.merge(options)
    json
  end
end
