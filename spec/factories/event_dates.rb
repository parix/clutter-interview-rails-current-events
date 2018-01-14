FactoryGirl.define do
  factory :event_date do
    date "2018-01-12"

		after(:create) do |event_date|
      5.times do
        create(:event, :event_date_id => event_date.id)
      end
		end
  end
end
