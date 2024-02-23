# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_categories_on_name     (name) UNIQUE
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord
  # validates presence, uniqueness and case-sensitivity of name attribute
  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "Category name must be unique" }
  
  belongs_to :user
  has_many :businesses, dependent: :destroy
end
