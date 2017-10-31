class ReservationMailer < ApplicationMailer
	default from: 'pairbnb.test2017@gmail.com'


	def booking_email(customer, host, reservation_id)
		@customer = customer 
		@host =  host 
		@reservation_id = reservation_id
		@url = 'http://localhost:3000/sign_in'
		@reservation = Reservation.find(@reservation_id)



		mail(to: @host.email,
         subject: 'New Booking from pairbnb')
	end 

end
