class UsersController < Clearance::UsersController


  #182 image uploading
  def edit
    @user = User.find(params[:id])
  end

  #182 image uploading; edit & update go hand-in-hand
  def update
    @user = current_user
     @user.update(user_params)
     # @user.save
      render template: "statics/home"
  end


  #182 image uploading; show what has been edited
  def show
     @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end
  # I have new method, because I wrote user_params priavte method; and clearnce has user_from params, and not this.

  def index
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end





  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :avatar)
  end



 # def user_from_params
 #  email = user_params.delete(:email)
 #  name = user_params.delete(:name)
 #  password = user_params.delete(:password)
 #  avatars = user_params.delete(:avatars)

 #  Clearance.configuration.user_model.new(user_params).tap do |user|
 #    user.email = email
 #    user.name = name
 #    user.password = password
 #    user.avatars  = avatars
 #  end


  # end

end