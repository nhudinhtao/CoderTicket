class EventsController < ApplicationController
  before_action :require_login, except: [ :index, :show ]

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

  def new
    @event = Event.new(user: current_user)
    @venues = Venue.all
    @categories = Category.all
  end

  def create 
    params[:event][:user] = current_user
    params[:event][:starts_at] = DateTime.strptime(params[:event][:starts_at], '%d/%m/%Y %H:%M:%S')
    params[:event][:ends_at] = DateTime.strptime(params[:event][:ends_at], '%d/%m/%Y %H:%M:%S')

    @event = Event.new event_params
    if @event.save
      flash[:success] = 'Event is created successfully'
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  private
  def event_params
    params.require(:event).permit(:user, :name, :venue_id, :category_id,  :hero_image_url, :extended_html_description, :starts_at, :ends_at)
  end
end
