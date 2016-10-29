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
        
        if (quantity.to_i > ticketType.max_quantity)
          flash[:error] = 'Cannot buy ' + ticketType.name + ', there are only ' + ticketType.max_quantity.to_s + ' tickets.'
          redirect_to new_event_ticket_path(ticketType.event) and return
        end

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
