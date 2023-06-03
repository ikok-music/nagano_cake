class Item < ApplicationRecord

  has_one_attached :image

  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :cart_items, dependent: :destroy
  belongs_to :genre, optional: true

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :price, presence: true

  # 消費税メソッド
  def with_tax_price
    (price * 1.1).floor
  end

  def get_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

end
