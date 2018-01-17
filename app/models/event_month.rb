class EventMonth < ActiveRecord::Base
  has_many :event_dates

  validates :month, :uniqueness => true, :presence => true

  def queue_job?
    !up_to_date? && !updating?
  end

  def updating?
    status == "Updating"
  end

  def up_to_date?
    checksum == latest_checksum
  end

  def latest_checksum
    Digest::MD5.hexdigest(open("https://en.wikipedia.org/wiki/Portal:Current_events/#{month}", &:read))
  end
end
