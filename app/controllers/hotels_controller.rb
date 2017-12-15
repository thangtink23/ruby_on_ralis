class HotelsController < ApplicationController
  def index
    @hotels = Hotel.where(status: 'accept')
    @hotelsPaginate = Hotel.where(status: 'accept').paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json {render :json => @hotels}
    end
  end

  def show
    @hotel = Hotel.find_by(id: params[:id])
    @reviews = @hotel.reviews.paginate(page: params[:page])
    if @hotel.status == 'pending'
      redirect_to wait_accept_path
    end
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.create(hotel_params)
    @hotel.user_id = current_user.id
    if @hotel.save
      # redirect ve trang show chi tiet khach san hotels/show
      redirect_to check_hotel_path
    else
      render "hotels/new"
    end
  end

  def update
    hotel = Hotel.find_by(id: params[:hotel][:hotel_id])
    if hotel.status == 'pending'
      hotel.update_attributes(status: 'accept')
    elsif hotel.status == 'accept'
      hotel.update_attributes(status: 'pending')
    end
    redirect_to check_hotel_path
  end

  def destroy
    hotel = Hotel.find_by(id: params[:hotel][:hotel_id])
    hotel.destroy
    redirect_to check_hotel_path
  end

  def check_hotel
    if user_signed_in?
      if current_user.admin?
        @hotels = Hotel.all.order(created_at: :desc)
      else
        @hotels = Hotel.where(user_id: current_user.id).order(created_at: :desc)
      end
    end
  end


  private

  def hotel_params
    params.require(:hotel).permit(:name, :address, :phone, :description, :avatar, :star, :min_price, :max_price)
  end

end
