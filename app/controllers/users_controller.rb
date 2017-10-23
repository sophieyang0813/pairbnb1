class UsersController < Clearance::UsersController

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      # render template: "users/new"
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end





  private

   def user_from_params
    email = user_params.delete(:email)
    name = user_params.delete(:name)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.name = name
      user.password = password
    end


  end






end