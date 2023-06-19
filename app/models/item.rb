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
    (self.price * Constants::Tax_rate).floor
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
