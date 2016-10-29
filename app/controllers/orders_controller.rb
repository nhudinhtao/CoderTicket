class OrdersController < ApplicationController
  before_action :require_login
  def index
    @orders = Order.where(user: current_user)
  end

  def new
  end

  def create
    @quantities = params[:quantity]
    @order = Order.new(user: @current_user)

    @quantities.each do |ticketType, quantity|
      if quantity.to_i > 0
        ticketType = TicketType.find(ticketType)
        orderItem = OrderItem.new(order: @order, ticket_type: ticketType, quantity: quantity.to_i) 
        orderItem.save
      end
    end
    redirect_to orders_path
  end

  def show
  end

  def destroy
  end
end
