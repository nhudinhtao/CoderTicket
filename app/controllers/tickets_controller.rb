class TicketsController < ApplicationController
  before_action :require_login
  def new
    @event = Event.find(params[:event_id])
  end

end
