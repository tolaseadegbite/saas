# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  businesses_count       :integer          default(0), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  firstname              :string           not null
#  phone_number           :bigint
#  products_count         :integer          default(0), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  stores_count           :integer          default(0), not null
#  surname                :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_number          (phone_number) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :surname, presence: true
  validates :firstname, presence: true

  def fullname
    "#{firstname} #{surname}"
  end

  has_many :categories, dependent: :destroy
  has_many :businesses, dependent: :destroy, counter_cache: :businesses_count
  has_many :products, dependent: :destroy, counter_cache: :products_count
  has_many :stores, dependent: :destroy, counter_cache: :stores_count

  # has_one_attached :avatar
end
