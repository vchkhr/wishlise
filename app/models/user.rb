class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :delete
  has_many :wishlists, dependent: :delete_all
  has_many :items, through: :wishlists, dependent: :delete_all
end
