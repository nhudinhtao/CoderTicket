class TicketTypesController < ApplicationController
  def index
  end

  def new
    @ticketType = TicketType.new
  end

  def create
    @ticketType = TicketType.new ticket_type_params
    event_id = params[:event_id]
    @ticketType.event_id = event_id
    if @ticketType.save
      flash[:success] = 'Ticket Type has created successfully'
      redirect_to event_path(event_id)
    else
      flash[:error] = 'Ticket Type has not created, please try again.'
      render 'new'
    end
  end

  private

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end
end
