class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user
  before_validation :set_inviting_status
  validates :team, uniqueness: { scope: :user }
  enum inviting_status: {
    pending: 0,
    confirmed: 1,
  }

  private

    def set_inviting_status
      self.inviting_status = :pending unless self.inviting_status
    end
end
