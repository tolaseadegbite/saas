# == Schema Information
#
# Table name: customers
#
#  id                       :bigint           not null, primary key
#  email                    :string
#  name                     :string           not null
#  phone_number             :string
#  product_item_dates_count :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  business_id              :bigint           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_customers_on_business_id   (business_id)
#  index_customers_on_email         (email) UNIQUE
#  index_customers_on_name          (name) UNIQUE
#  index_customers_on_phone_number  (phone_number) UNIQUE
#  index_customers_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
class Customer < ApplicationRecord
  before_save :downcase_email

  # validates presence, length and uniqueness of name in a particular business
  validates :name, presence: true, uniqueness: {scope: :business_id, message: "Name must be unique"}, length: { minimum: 3, maximum: 50 }

  # valid email format
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # validates presence, length, format and uniqueness of email address
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { scope: :business_id, case_sensitive: false, message: "Email name must be unique" }

  # validates presence, uniqueness and length of phone number
  validates :phone_number, presence: true, uniqueness: {scope: :business_id, message: "Phone number must be unique"}

  # associations
  belongs_to :user, counter_cache: :customers_count
  belongs_to :business, counter_cache: :customers_count
  
  has_many :product_item_dates, dependent: :destroy, counter_cache: :product_item_dates_count

  # customers should be ordered in descending order
  scope :ordered, -> { order(id: :desc) }

  private

    # Converts email to all lowercase
    def downcase_email
      email.downcase!
    end
end
