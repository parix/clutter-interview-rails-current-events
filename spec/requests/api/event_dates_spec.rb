require 'rails_helper'

describe 'Event Dates API' do
  context "GET /api/event_dates" do
    before do
      create(:event_date)
      create(:event_date, :date => "2018-1-11")
    end

    it "renders all available dates in JSON" do
      get "/api/event_dates.json"
      expect(JSON.parse(response.body).count).to eq(2)
    end
  end

  context "GET /api/event_dates/:date" do
    before do
      create(:event_date)
      create(:event_date, :date => "2018-1-11")
    end

    it "renders all events that occurred on the specified date in JSON" do
      get "/api/event_dates/2018-1-11.json"
      expect(JSON.parse(response.body).count).to eq(5)
    end
  end
end
