class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find_by(id: params[:user_id])
    @locations = @user.locations
  end

  def show
    @location = Location.find_by(id: params[:id])
  end

  def new
    @location = Location.new
  end

  def edit; end

  def create
    @location = current_user.locations.new(locations_params)
    locations_cordinates = place_cordinates
    if locations_cordinates
      @location.latitude = locations_cordinates.first
      @location.longitude = locations_cordinates.second
      @location.save
      redirect_to edit_user_registration_path
    else
      flash[:alert] = locations_cordinates.to_s
      render :new
    end
  end

  def destroy
    @location = Location.find_by(id: params[:id])
    @location.destroy
    redirect_to edit_user_registration_path
  end

  private

  def locations_params
    params.require(:location).permit(:street, :city, :state, :country)
  end

  def place_cordinates
    objects = Geocoder.search(@location.address)
    if !objects.empty?
      data = objects.first.data
    else
      return
    end
    [data['lat'], data['lon']]
  end
end
