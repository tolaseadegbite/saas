# == Schema Information
#
# Table name: stores
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  store_products_count :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  business_id          :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_stores_on_business_id  (business_id)
#  index_stores_on_name         (name) UNIQUE
#  index_stores_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
class Store < ApplicationRecord
  # validates presence, uniqueness, length and case-sensitivity of name attribute
  validates :name, presence: true, uniqueness: {scope: :business_id, message: "Store name must be unique"}, length: { minimum: 3, maximum: 255 }

  belongs_to :user, counter_cache: :stores_count
  belongs_to :business, counter_cache: :stores_count

  # store products association
  has_many :store_products, inverse_of: :store, dependent: :destroy
  has_many :products, through: :store_products, dependent: :destroy

  # nested form nested attributes
  accepts_nested_attributes_for :store_products, reject_if: :all_blank, allow_destroy: true
end
