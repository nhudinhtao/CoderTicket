require 'rails_helper'

RSpec.describe "orders/index.html.erb", type: :view do
  before(:each) do
    @user = User.create(email: 'a@a.com', name: 'A Test', password: '1234')
    @venue1 = Venue.create!(name: "Da lat")
    @category1 = Category.create!(name: "Entertainment")
    @event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))
    @ticketType1 = TicketType.create(event: @event1, price: 500000, name: "Live show Lara Fabian", max_quantity: 95)
    @order1 = Order.create(user: @user)
    @orderItem1 = OrderItem.create(order: @order1, ticket_type: @ticketType1, quantity: 2)
    @orders = [@order1]
  end

  after(:all) do
    Venue.delete_all
    Category.delete_all
    Event.delete_all
    Order.delete_all
    OrderItem.delete_all
    TicketType.delete_all
    User.delete_all
  end

  it "check index contain" do
    render
    expect(rendered).to match /Live show Lara Fabian/
  end

  it "check total money" do
    render
    expect(rendered).to match /Total: VND 1,000,000/
  end
end
