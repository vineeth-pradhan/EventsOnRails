class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def seed_users row
    User.create(username: row[0], email: row[1], phone: row[2])
  end
end
