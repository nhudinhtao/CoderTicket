require 'rails_helper'

RSpec.describe Event, type: :model do

  before(:each) do
    @venue1 = Venue.create!(name: "Da lat")
    @category1 = Category.create!(name: "Entertainment")
    @event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))
  end
  
  it "show upcoming event" do
    expect(Event.upcoming).to eq [@event1]
  end

  it "search event" do 
    expect(Event.search("Event 1")).to eq [@event1]
  end
  
end

