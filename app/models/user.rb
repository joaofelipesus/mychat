class User < ApplicationRecord
  validates_presence_of :name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :teams, through: :team_users

  def my_groups
    Team.where(owner: self) + self.teams
  end

end
