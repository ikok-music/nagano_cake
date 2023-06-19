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

  enum payment_method: {"クレジットカード": 0,"銀行振込": 1}
	enum status: {"入金待ち": 0,"入金確認": 1,"製作中": 2,"発送準備中": 3, "発送済み": 4}

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  def address_display_nameless
    '〒' + postal_code + ' ' + address
  end

end
