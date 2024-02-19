# == Schema Information
#
# Table name: businesses
#
#  id            :bigint           not null, primary key
#  business_code :string           not null
#  description   :text
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_businesses_on_category_id  (category_id)
#  index_businesses_on_name         (name) UNIQUE
#  index_businesses_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Business < ApplicationRecord

  before_create :create_business_code
  validates :name, presence: true, uniqueness: {scope: :user_id, message: "Business name must be unique"}, length: { minimum: 3, maximum: 50 }

  belongs_to :category
  belongs_to :user

  scope :ordered, -> { order(id: :desc) }

  def Business.new_token
    SecureRandom.urlsafe_base64(4)
  end

  def create_business_code
    self.business_code = Business.new_token
  end
end
