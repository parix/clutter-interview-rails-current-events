require 'rails_helper'

describe Event, type: :model do
  describe "#to_hash" do
    let(:event_date) { create(:event_date) }
    subject { create(:event, :event_date => event_date).to_hash }

    it "contains the title" do
      expect(subject["title"]).to eq("Article")
    end

    it "contains the summary" do
      expect(subject["summary"]).to eq("Summary")
    end

    it "contains the image url" do
      expect(subject["image_url"]).to eq("Image URL")
    end
  end
end
