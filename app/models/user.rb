class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter
  has_many :enrollments
  has_many :teams, through: :enrollment
  has_many :quotes

  validates :nickname, presence: :true, uniqueness: :true, on: :update

end
