require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before(:each) do
    @venue1 = Venue.create!(name: "Da lat")
    @category1 = Category.create!(name: "Entertainment")
    @event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event 1</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44), published_at: Time.now)
    @event2 = Event.create!(name: "Event 2", extended_html_description: "<p>this is a test event 2</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 11, 24, 01, 04, 44), published_at: Time.now)
    @event3 = Event.create!(name: "Event 3", extended_html_description: "<p>this is a test event 3</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 1, 24, 01, 04, 44), published_at: Time.now)
  end

  after(:all) do
    Venue.delete_all
    Category.delete_all
    Event.delete_all
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns valid event" do
      get :index
      expect(assigns(:events)).to eq [@event1, @event2]
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to redirect_to(login_path)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create
      expect(response).to redirect_to(login_path)
    end
  end
end