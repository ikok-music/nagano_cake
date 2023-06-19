class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy
  belongs_to :customer

  validates :customer_id, presence: true
  validates :shipping_cost, presence: true, numericality: { only_integer: true }
  validates :total_payment, presence: true, numericality: { only_integer: true }
  validates :payment_method, presence: true
  validates :postal_code, presence: true, length: {is: 7}, numericality: { only_integer: true }
  validates :address, presence: true
  validates :name, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }

	enum status: { unpaid: 0, deposit_confirmation: 1, production: 2, preparation: 3, shipped: 4 }

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  def address_display_nameless
    '〒' + postal_code + ' ' + address
  end

end
