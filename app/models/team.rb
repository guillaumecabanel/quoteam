class Team < ApplicationRecord
  has_many :quotes, dependent: :destroy
  has_many :enrollments

  validates :name, presence: true, uniqueness: true

  # record a secret id to invite members
  before_create do |team|
    digest = Digest::SHA2.new.to_s << Time.now.to_s
    team.secret_id = digest.split(//).sample(10).join
  end

end
