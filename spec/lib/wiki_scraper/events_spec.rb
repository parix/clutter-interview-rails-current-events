require 'spec_helper'

describe WikiScraper::Events, :vcr do
  context '.get_events' do
    subject { WikiScraper::Events.get_events(month: "January_2018") }

    it 'returns events from Wikipedia in a hash' do
      expect(subject).to be_kind_of(Hash)
    end

    it 'returns all available dates' do
      expect(subject.keys.count).to eq(13)
    end
  end
end
