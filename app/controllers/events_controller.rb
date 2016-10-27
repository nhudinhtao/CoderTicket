class EventsController < ApplicationController
  def index
    query = params[:search]
    if query
      @events = Event.search(query)
    else
      @events = Event.upcoming    
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
