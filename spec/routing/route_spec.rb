require 'rails_helper'

RSpec.describe "routing to events", :type => :routing do
  it "route /upcoming to events#index" do
    expect(:get => "/upcoming").to route_to(
      :controller => "events",
      :action => "index"
    )
  end

  it "route /login to sessions#new" do
    expect(:get => "login").to route_to(
      :controller => "sessions",
      :action => "new"
      )
  end

  it "route /signup to users#new"  do
    expect(:get => "signup").to route_to(
      :controller => "users",
      :action => "new"
      )
  end

end
