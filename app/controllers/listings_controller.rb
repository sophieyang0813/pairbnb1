class ListingsController <  ApplicationController
    

  def home 
  end 

  def edit
    @listing = Listing.find(params[:id])
  end

  #182 image uploading; edit & update go hand-in-hand
  def update

    @listing = Listing.find(params[:id])
      if @listing.update(listing_params)
     # @listing.save
     redirect_to :listing, :flash => { :success => "Updated successfully!" }
      else 
     redirect_to :edit_listing, :flash => { :error => "Oops, please try again" }
      # render template: "listings/show", :flash => { :success => "Updated successfully!" }
      end


  end
    





    def show
      @listing = Listing.find(params[:id])
      # 182 image uploading new & update methods
    end

    def search
      #195B search engine see listing model 
        @listings = Listing.where(nil)
        # Pgsearch.multisearch(params[:query])
        filtering_params(params).each do |key, value|
          @listings = @listings.public_send(key, value) if value.present?
        end 
        # byebug 
    end

      
      def index
        #180 pagination 
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
        #181 authorization
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
            render 'show', notice: 'Listing was successfully created.'
        else
            render 'new'
        end
    end


    private


     def filtering_params(params)
      params.slice(:price_range, :city, :room_type, :everything)
     end 
     #195C search engine 


     def listing_params
          # if !self.search, 
         params.require(:listing).permit(:guest_num, :location, :room_type, :price_per_night, {avatars:[]})
     end
end