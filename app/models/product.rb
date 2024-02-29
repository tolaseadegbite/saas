# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  description  :text
#  name         :string           not null
#  product_code :string           not null
#  unit_price   :decimal(10, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  business_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_products_on_business_id  (business_id)
#  index_products_on_name         (name) UNIQUE
#  index_products_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  before_create :create_product_code

  # validates presence, uniqueness, length and case-sensitivity of name attribute
  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "Product name must be unique" }, length: { minimum: 3, maximum: 50 }

  # validates presence and numericality of quantity (only integer values greater than zero will be accepted)
  # validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # validates presence and numericality of unit price (only values greater than zero will be accepted)
  validates :unit_price, presence: true, numericality: { greater_than: 0 }

  belongs_to :user, counter_cache: :products_count
  belongs_to :business, counter_cache: :products_count

  # store products association
  has_many :store_products, dependent: :destroy
  has_many :stores, through: :store_products

  # order products by name in ascending order
  scope :ordered, -> { where('name LIKE ?', "a%").order(:name) }

  # create new token
  def Product.new_token
    SecureRandom.urlsafe_base64(4)
  end

  # update product_code attribute with the generated token
  def create_product_code
    self.product_code = Product.new_token
  end
end
