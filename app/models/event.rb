class Event < ApplicationRecord
  validates :title, presence: true
  validates :allday, :presence: true

  def seed_data row
    Event.transaction do 
      Event.create(title: row[0], startime: row[1], endtime: row[2], description: row[3], allday: row[5])
    end
  end
end
