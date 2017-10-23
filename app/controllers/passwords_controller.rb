class PasswordsController < Clearance::PasswordsController

  def edit
    @user = find_user_for_edit
        # byebug
    if params[:token]
      session[:password_reset_token] = params[:token]
      redirect_to url_for
    else
      render template: 'passwords/edit'
    end
  end


end