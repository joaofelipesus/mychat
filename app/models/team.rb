class Team < ApplicationRecord
  belongs_to :owner, class_name: :User
  validates_presence_of :slug
  has_many :groups, dependent: :destroy
  after_create_commit :generate_general_channel
  validates_uniqueness_of :slug
  validates_format_of :slug, with: /\A[a-zA-Z0-9]+\Z/
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users

  private

    def generate_general_channel
      self.groups << Group.new({
        owner: self.owner,
        slug: 'general'
      })
    end

end
