class MobilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @mobile = Mobile.new
  end

  def create
    if valid_mobile?
      current_user.mobiles.create(mobile_params)
      redirect_to edit_user_registration_path
    else
      render :new
    end
  end

  def destroy
    @mobile = Mobile.find_by(id: params[:id])
    @mobile.destroy
    redirect_to edit_user_registration_path
  end

  private

  def mobile_params
    params.require(:mobile).permit(:number, :country)
  end

  def valid_mobile?
    phone_object = TelephoneNumber.parse(params[:mobile][:number], params[:mobile][:country])
    phone_object.valid?
  end
end
