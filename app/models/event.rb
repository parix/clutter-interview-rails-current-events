class Event < ActiveRecord::Base
  belongs_to :event_date

  validates :event_date, :presence => true

  def to_hash
    { "title" => title,
      "summary" => summary,
      "image_url" => image_url }
  end
end
