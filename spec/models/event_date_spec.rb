require 'rails_helper'

describe EventDate, :type => :model, :vcr => { :cassette_name => "WikiEvents/January_2018" } do
  let(:event_date) { EventDate.find_by(:date => "2018-1-1") }

  before do
    ScrapeWikiWorker.perform_async("January_2018")
  end

  describe "#to_hash" do
    subject { event_date.to_hash }

    it "contains the date" do
      expect(subject["date"]).to eq("2018-01-01")
    end

    it "contains the href" do
      expect(subject["href"]).to eq("/date/2018-01-01")
    end
  end

  describe "#events_hash" do
    subject { event_date.events_hash }

    it "contains the status" do
      expect(subject["status"]).to eq("Updated")
    end

    it "contains the status" do
      expect(Date.parse(subject["last_update_at"])).to eq(Date.today)
    end

    it "contains the events" do
      expect(subject["events"].count).to eq(11)
    end
  end

  describe "#last_update_at" do
  end
end
