class User < ApplicationRecord
  has_many :rsvps
  has_many :events, through: :rsvps

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.seed_data row
    User.create(username: row[0], email: row[1], phone: row[2])
  end
end
