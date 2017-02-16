class Team < ApplicationRecord
  has_many :quotes
  has_many :users

  validates :name, presence: true, uniqueness: true

end
