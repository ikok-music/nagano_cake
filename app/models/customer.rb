class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: {with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, presence: true, format: {with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :postal_code, presence: true, length: {is: 7}, numericality: { only_integer: true }
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, uniqueness: true

  def activ_for_authentication?
    super && (self.is_deleted == false)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end

  def address_display_nameless
    '〒' + postal_code + ' ' + address
  end

  def full_name
    last_name + first_name
  end

  def full_name_space
    last_name + ' ' + first_name
  end

end
