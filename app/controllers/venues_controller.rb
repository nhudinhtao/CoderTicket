class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
    @regions = Region.all
  end

  def create
    @venue = Venue.new venue_params
    if @venue.save
      flash[:success] = 'Create venue successfully.'
      redirect_to venues_index_path 
    else
      flash[:success] = 'There are some error, please try again.'
      render 'new'
    end
  end

  private 
  def venue_params
    params.require(:venue).permit(:region_id, :name, :full_address)
  end
end
