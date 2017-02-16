class Quote < ApplicationRecord
  acts_as_votable
  belongs_to :team

  validates :content, presence: true
  validates :author, presence: true
end
