class ListingsController <  ApplicationController

    def index
        if params[:page]# iahve parms page, i offset by the params page #true(not false or not nil))
          if params[:page].empty? #params page is empty
            @page = 1
            @listings = Listing.all.limit(10).offset(@page * 10)
          else
            @page = params[:page].to_i
            @listings = Listing.all.limit(10).offset(@page * 10)
            #offset not by 5 but by whatever params page is
            if @listings.include?(Listing.all.last)
              @page = params[:page].to_i
              @listings = Listing.all.limit(10).offset(@page * 10)
            else
            end
          end
        else #i jsut do it normally (show first five, no need to offest)
            # @page = 1
            @listings = Listing.all.limit(10).offset(0)
        end

    end

    def new
        @listing = Listing.new
        if current_user.moderator?
          flash[:notice] = "Sorry. You are not allowed to perform this action."
          return root_path, notice: "Sorry, You do not have the permission to verify a property."
        end
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