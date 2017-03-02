class Quote < ApplicationRecord
  acts_as_votable
  belongs_to :team
  belongs_to :user

  validates :content, presence: true
  validates :author, presence: true

end
