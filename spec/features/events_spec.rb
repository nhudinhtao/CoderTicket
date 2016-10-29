require 'rails_helper'

RSpec.feature "Events", type: :feature do
  before(:each) do
    @user = User.create(email: 'a@a.com', name: 'A Test', password: '1234')
    @venue1 = Venue.create!(name: "Da lat")
    @category1 = Category.create!(name: "Entertainment")
    @event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))
  end

  after(:all) do
    Venue.delete_all
    Category.delete_all
    Event.delete_all
    User.delete_all 
  end

  scenario "visit click on event to see event detail" do
    visit root_path
    visit event_path(@event1.id)

    expect(page).to have_content 'Event 1'
    expect(page).to have_content 'this is a test event'
    expect(page).to have_content 'BOOK NOW'
  end

  scenario "can not book ticket without sign in" do
    visit root_path
    visit event_path(@event1.id)
    click_link "BOOK NOW"
    expect(page).to have_content 'You must sign in to see this page'
  end

  scenario "visit click BOOK NOW to buy tickets" do
    visit login_path
    fill_in "email", :with => @user.email
    fill_in "password", :with => @user.password
    click_button "Log In"

    expect(page).to have_content "Login successfully."
    
    visit root_path
    visit event_path(@event1.id)
    click_link "BOOK NOW"

    expect(page).to have_content 'Event 1'
    expect(page).to have_content 'Buy'
  end
end

