require 'rails_helper'

RSpec.describe "events/new.html.erb", type: :view do
  before(:each) do
    @user = User.create(email: 'a@a.com', name: 'A Test', password: '1234')
    @venue1 = Venue.create!(name: "Da lat")
    @venues = [@venue1]
    @category1 = Category.create!(name: "Entertainment")
    @categories = [@category1]
    @event = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))
  end

  after(:all) do
    Venue.delete_all
    Category.delete_all
    Event.delete_all
    User.delete_all
  end

  it "check new page is worked" do
    render
    expect(rendered).to match /Create your event/
  end
end