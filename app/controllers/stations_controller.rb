class StationsController < ApplicationController
  before_action :require_admin
  
  def index
    @stations = Station.all.order(identifier: :asc)
  end
  
  def show
    @station = Station.find(params[:id])
    @bikes = Bike.where(current_station_id: @station.identifier)
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)

    begin 
      @station.save!
      flash.notice = "New station saved!"
      redirect_to stations_path
    rescue ActiveRecord::RecordInvalid => e
      flash.alert = e
      render 'new', :status => :unprocessable_entity
    end
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(station_params)
      redirect_to station_path(@station)
    else
      render('edit')
    end
  end

  def delete
    @station = Station.find(params[:id])
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    redirect_to stations_path
  end
  
  private

  def station_params
    params.require(:station).permit(
      :identifier,
      :name,
      :address,
      :status,
      :longitude,
      :latitude,
      :theme_name
    )
  end

  def require_admin
    unless user_signed_in? and current_user.admin
      flash[:error] = "You do not have permission to access this page."
      redirect_to root_path
    end
  end

end
