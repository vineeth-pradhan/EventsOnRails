class Event < ApplicationRecord
  has_many :rsvps
  has_many :users, through: :rsvps

  validates :title, presence: true
  before_create :check_validity, :check_completion

  def self.seed_data row
    transaction do 
      event = create_from_csv row
      begin
        row[4].split(';').each do |subrow|
          Rsvp.seed_data subrow.split('#') << event
        end
      rescue
        SeedError.create(description: event.title)
      end
    end
  end

  private

  def self.create_from_csv row
    event = new(
      title: row[0],
      description: row[3],
      allday: row[5],
      starttime: row[1] ||= nil,
      endtime: row[2] ||= nil,
    )
    event.save
    event
  end

  def check_validity
    self.endtime = nil if self.allday == true
  end

  def check_completion
    self.complete = true if !self.allday && Time.now > self.endtime
  end
end
