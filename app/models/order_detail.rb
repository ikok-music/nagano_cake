class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

	validates :item_id, presence: true, numericality: { only_integer: true }
	validates :order_id, presence: true, numericality: { only_integer: true }
	validates :amount, presence: true, numericality: { only_integer: true }
	validates :price, presence: true, numericality: { only_integer: true }

  enum making_status: {"製作不可": 0,"製作待ち": 1,"製作中": 2,"製作完了": 3}

  # 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end

end
