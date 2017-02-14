class Quote < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true
end
