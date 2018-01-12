class EventDate < ActiveRecord::Base
  has_many :events

  validates :date, :uniqueness => true

  def to_json
    to_hash.to_json
  end

  def to_hash
    { "date" => date,
      "href" => "/event_date/#{date.to_s}" }
  end
  # checksum
  # Digest::MD5.hexdigest(open("https://en.wikipedia.org/wiki/Portal:Current_events/January_2011", &:read))
end
