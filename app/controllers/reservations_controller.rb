class ReservationsController <  ApplicationController

  def new
   @reservation = Reservation.new
   @listing = Listing.find(params[:listing_id])


  end


  def create
   @reservation = Reservation.new
   @reservation.user_id = current_user.id
   @reservation.listing_id = params[:listing_id]  # listing_id that current user clicked

      if @reservation.save
        render 'show'
      else
        render 'new'
      end
  end


 private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out)
  end


end