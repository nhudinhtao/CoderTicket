require 'rails_helper'

RSpec.feature "Events", type: :feature do
  before(:each) do
    @venue1 = Venue.create!(name: "Da lat")
    @category1 = Category.create!(name: "Entertainment")
    @event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))
  end

  after(:all) do
    Venue.delete_all
    Category.delete_all
    Event.delete_all
  end

  scenario "visit click on event to see event detail" do
    visit root_path
    visit event_path(@event1.id)

    expect(page).to have_content 'Event 1'
    expect(page).to have_content 'this is a test event'
    expect(page).to have_content 'BOOK NOW'
  end
end

