class EventsController < ApplicationController
  before_action :require_login, except: [ :index, :show ]
  before_action :check_event_changing_permission, except: [ :index, :show, :new, :create, :mine]

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
    params[:event][:user_id] = current_user.id
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

  def publish_event
    @event = Event.find(params[:id])
    @event.published_at = Time.now

    if @event.ticket_types.count <= 0
      flash[:error] = 'Publish error! Please add some ticket types first.'
      redirect_to event_path(@event) and return
    end

    if @event.save
      flash[:success] = 'Event published.'
    else
      flash[:error] = 'Publish error! Please try again.'
    end

    redirect_to event_path(@event)
  end

  def mine
    @events = Event.where(user: current_user)
  end

  def edit
    @event = Event.find(params[:id])
    @venues = Venue.all
    @categories = Category.all
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'Event has updated'
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  private
  def event_params
    params.require(:event).permit(:user_id, :name, :venue_id, :category_id,  :hero_image_url, :extended_html_description, :starts_at, :ends_at)
  end

  def check_event_changing_permission
    @event = Event.find(params[:id])
    if @event.user_id == current_user.id
    else
      flash[:error] = 'Only owner of this event can edit it.'
      redirect_to event_path(@event)
    end
  end
end
