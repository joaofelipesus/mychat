class User < ApplicationRecord
  validates_presence_of :name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :team_users
  has_many :teams, through: :team_users

  def my_teams
    memeber_teams =  self.team_users.confirmed.map { |team_user| team_user.team_id }
    Team.where(owner: self) + Team.where(id: memeber_teams)
  end

end
