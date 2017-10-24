class ListingsController <  ApplicationController

    def new
        @listing = Listing.new
    end

    def create

        @listing =Listing.new(listing_params)
        # byebug
        @listing.user_id = current_user.id

        if @listing.save
            render 'host'
        else
            render 'new'
        end
    end

    private

        def listing_params
            params.require(:listing).permit(:guest_num, :location, :room_type)
        end
end