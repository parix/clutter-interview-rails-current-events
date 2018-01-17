class EventDate < ActiveRecord::Base
	belongs_to :event_month
  has_many :events

  validates :date, :uniqueness => true, :presence => true
  validates :event_month, :presence => true

  def to_hash
    { "date" => date.to_s,
      "href" => "/#{date.to_s}" }
  end

  def events_hash
    { "status" => event_month.status,
      "last_update_at" => last_update_at,
      "events" => events.map(&:to_hash) }
  end

  def last_update_at
    if event_month.checksum
      event_month.updated_at.to_s
    else
      "never"
    end
  end
end
