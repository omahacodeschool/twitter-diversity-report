class UsersController < ApplicationController
  def selfresult
    @user = User.find_by twitter_id: (session[:twitter_id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by twitter_id: (session[:twitter_id])
    if @user == nil
      # flash[:message] = "An error occured. Please log in."
      redirect_to "/logout"
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to "/users/#{session[:screen_name]}/edit"

    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to "/users/self/result"

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to "/"
  end

  private
    def user_params
      if params[:user][:education] == ""
        params[:user][:education] = nil
      end
      params.require(:user).permit(:twitter_id, :age, :income, :education, :orientations_textarea, :ethnicities_textarea, :genders_textarea)
    end
end
