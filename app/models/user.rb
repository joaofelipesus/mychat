class User < ApplicationRecord
  validates_presence_of :name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
end
