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

  # has_one_attached :avatar
end
