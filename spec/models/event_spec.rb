require 'rails_helper'

def event_link
  page.all(:css, "h4.card-title").map(&:text)
end

RSpec.describe Event, type: :model do
  
  it "show upcoming event" do
    # create new event and it will show on page
    venue1 = Venue.create!(name: "Da lat")
    category1 = Category.create!(name: "Entertainment")
    event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: venue1, category: category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))

    expect(Event.upcoming).to eq [event1]

  end
  
end

