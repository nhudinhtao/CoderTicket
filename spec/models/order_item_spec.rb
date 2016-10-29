require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before(:each) do
    @user = User.create(email: 'a@a.com', name: 'A Test', password: '1234')
    @venue1 = Venue.create!(name: "Da lat")
    @category1 = Category.create!(name: "Entertainment")
    @event1 = Event.create!(name: "Event 1", extended_html_description: "<p>this is a test event</p>", venue: @venue1, category: @category1,  starts_at: Time.new(2016, 12, 24, 01, 04, 44))
    @ticketType1 = TicketType.create(event: @event1, price: 500000, name: "Live show Lara Fabian", max_quantity: 95)
    @ticketType2 = TicketType.create(event: @event1, price: 1000000, name: "VIP in Live show Lara Fabian", max_quantity: 20)
    @order1 = Order.create(user: @user)
    @orderItem1 = OrderItem.create(order: @order1, ticket_type: @ticketType1, quantity: 2)
    @orderItem2 = OrderItem.create(order: @order1, ticket_type: @ticketType2, quantity: 3)
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

  it "check order item via order item" do
    expect(@orderItem1.order.id).to eq @order1.id
  end

  it "check multi order item via order item" do
    expect(@orderItem2.order.id).to eq @order1.id
  end
end
