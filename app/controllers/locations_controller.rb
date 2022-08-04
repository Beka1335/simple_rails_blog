class LocationsController < ApplicationController
  before_action :authenticate_user!

  # GET /locations or /locations.json
  def index
    @user = User.find_by(id: params[:user_id])
    @locations = @user.locations
  end

  # GET /locations/1 or /locations/1.json
  def show
    @location = Location.find_by(id: params[:id])
  end

  # GET /locations/new
  def new
    @location = Location.new()
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = current_user.locations.new(locations_params)
    locations_cordinates = place_cordinates
    if locations_cordinates
      @location.latitude = locations_cordinates.first
      @location.longitude = locations_cordinates.second
      @location.save
      redirect_to edit_user_registration_path
    else
      flash[:alert] = "#{locations_cordinates}"
      render :new
    end
  end


  # DELETE /locations/1 or /locations/1.json
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
