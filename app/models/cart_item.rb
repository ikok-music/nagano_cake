class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer

  validates :customer_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }

  ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end

end
