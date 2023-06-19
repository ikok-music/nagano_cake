class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

	validates :item_id, presence: true, numericality: { only_integer: true }
	validates :order_id, presence: true, numericality: { only_integer: true }
	validates :amount, presence: true, numericality: { only_integer: true }
	validates :price, presence: true, numericality: { only_integer: true }

  enum making_status: { cannot_be_started: 0, awaiting_manufacture: 1, under_manufacture: 2, manufacturing_completed: 3 }

  # 小計を求めるメソッド
  def subtotal
    amount * price
  end

end
