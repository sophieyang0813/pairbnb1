class ReservationsController <  ApplicationController
  

  def new 
   @reservation = Reservation.new
   @listing = Listing.find_by(id: params[:listing_id])
   # @host = Listing.find_by(id: params[:listing_id]).user_id
  end


  def index
    @reservations = Reservation.all
  end

  def create
   @listing = Listing.find(params[:listing_id])
   @reservation = Reservation.new(reservation_params)
   @reservation.user_id = current_user.id
   @reservation.listing_id = params[:listing_id]
   @reservation.total_price = (@listing.price_per_night) * ((@reservation.check_out - @reservation.check_in)/86400) 



      if @reservation.save
        redirect_to listing_reservation_path(@listing,@reservation)
        #192 mailer 
        # ReservationMailer.booking_email( @reservation.user, @listing.user, @reservation.id).deliver_later
        #customer email: @reservation.user.email #host email:  @listing.user.email  #reservation_id: 
      else
        flash[:notice] = "Sorry. Your reservation date overlaps with the existing ones."
        render 'new'
      end

  end



### 191. braintree & APIs ##### CHANGE payment AMOUNT INFO ######

  def show 
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
    #191 payment; show.html.erb 
   @client_token = Braintree::ClientToken.generate 
  end 

  def checkout  #190 step 9:  make transactions on the server side (rails)
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    # is it possible to remember listing _id and id after submit the form? => nested route 
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:reservation_id])
    @reservation.total_price = (@listing.price_per_night) * ((@reservation.check_out - @reservation.check_in)/86400)

     result = Braintree::Transaction.sale(
     :amount => @reservation.total_price , # "10.00" @reservation.total_price #this is currently hardcoded/ hidden field for the reservation; 
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
      redirect_to :root, :flash => { :success => "Transaction successful!" }
         #192 mailer 
        @listing = Listing.find(params[:listing_id])
        @reservation = Reservation.find(params[:reservation_id])
        ReservationJob.perform_later(@reservation.user, @listing.user, @reservation.id)
        #customer email: @reservation.user.email #host email:  @listing.user.email  #reservation_id: 
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end

  end 






 private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out)
  end





end