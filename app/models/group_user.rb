class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  before_validation :set_invite_status
  enum invite_status: {
    pending: 0,
    confirmed: 1
  }

  private

    def set_invite_status
      self.invite_status = :pending unless self.invite_status
    end
end
