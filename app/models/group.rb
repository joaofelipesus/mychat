class Group < ApplicationRecord
  belongs_to :team
  belongs_to :owner, class_name: :User
  validates_presence_of :slug
  validates :slug, uniqueness: { scope: :team }
  validates_format_of :slug, with: /\A[a-zA-Z0-9]+\Z/ 
end
