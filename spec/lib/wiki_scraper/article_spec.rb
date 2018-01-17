require 'spec_helper'

describe WikiScraper::Article, :vcr => { :cassette_name => "WikiEvents/January_2018" } do
  context '.get_summary' do
    subject { described_class.get_summary("https://en.wikipedia.org/wiki/Kashmir_conflict") }

    it 'returns the summary of the Wikipedia article in a hash' do
      expect(subject).to be_kind_of(Hash)
    end

    it 'stores the title of the Wikipedia article'  do
      expect(subject["title"]).to eq("Kashmir conflict")
    end

    it 'stores the summary of the Wikipedia article'  do
      expect(subject["summary"]).to eq(file_fixture('kashmir_conflict_summary.html').read)
    end

    it 'stores the image url of the Wikipedia article'  do
      expect(subject["image_url"]).to eq("https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Kashmir_region_2004.jpg/220px-Kashmir_region_2004.jpg")
    end
  end
end
