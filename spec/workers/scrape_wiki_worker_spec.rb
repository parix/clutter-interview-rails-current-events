require 'rails_helper'

describe ScrapeWikiWorker, :type => :worker, :vcr => { :cassette_name => "WikiEvents/January_2018" } do
  context "#perform_async" do
    before do
      ScrapeWikiWorker.new.perform("January_2018")
    end

    it "scrapes and stores all events for January 2018" do
      expect(Event.count).to eq(180)
    end

    it "scrapes and stores all dates for January 2018" do
      expect(EventDate.count).to eq(21)
    end

    it "stores the latest checksum" do
      expect(EventMonth.find_by(:month => "January_2018").checksum).to eq("e759f91c4d06ed4da530ffb4c5742701")
    end
  end
end
