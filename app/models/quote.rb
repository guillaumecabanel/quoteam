class Quote < ApplicationRecord
  acts_as_votable
  
  validates :content, presence: true
  validates :author, presence: true
end
