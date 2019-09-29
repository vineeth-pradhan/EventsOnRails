class Event < ApplicationRecord
  has_many :rsvps
  has_many :users, through: :rsvps

  validates :title, :starttime, presence: true
  validates :allday, inclusion: [true, false]
  validates :endtime, presence: true, if: :timed_event?
  validates :complete, inclusion: [true, false]

  before_create :check_validity, :check_completion
  
  scope :valid_dates, -> { where('starttime < endtime') }
  scope :after_startdate, -> (date) { where('starttime >= ?', date) }
  scope :before_enddate, -> (date) { where('endtime <= ?', date) }

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
    self.complete = true if self.endtime && Time.now > self.endtime
  end

  def timed_event?
    !self.allday
  end
end
