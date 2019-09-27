class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  before_create :check_overlaps
  
  def self.seed_data row
    Rsvp.create(response: row[1], user_id: User.find_by_username(row[0]).id, event_id: row[2].id)
  end

  private

  def check_overlaps
    self.response = 'no' if self.user.events.where('starttime < ? AND endtime > ? AND response = "yes"', self.event.starttime, self.event.starttime).present?
  end
end
