require 'rails_helper'

describe 'Event Dates API' do
  context "GET /api/event_dates" do
    before do
      event_month = create(:event_month, :month => "January_2018")
      create(:event_date, :date => "2018-1-1", :event_month_id => event_month.id)
      create(:event_date, :date => "2018-1-2", :event_month_id => event_month.id)
    end

    it "renders all available dates in JSON" do
      get "/api/event_dates.json"
      expect(JSON.parse(response.body).count).to eq(2)
    end
  end

  context "GET /api/event_dates/:date", :vcr => { :cassette_name => "WikiEvents/January_2018" } do
    subject { JSON.parse(response.body) }

    it "returns the status of the event date in JSON" do
      get "/api/event_dates/2018-1-1.json"
      expect(subject['status']).to eq("Updated")
    end

    it "returns the last update date in JSON" do
      get "/api/event_dates/2018-1-1.json"
      expect(Date.parse(subject['last_update_at'])).to eq(Date.today)
    end

    it "returns all events that occurred on the specified date in JSON" do
      get "/api/event_dates/2018-1-1.json"
      expect(subject['events'].count).to eq(11)
    end
  end
end
