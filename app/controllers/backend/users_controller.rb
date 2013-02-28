class Backend::UsersController < Backend::ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:notice] = 'User was successfully created.'
      redirect_to backend_user_path(@user)
    else
      render new_backend_user_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to backend_user_path(@user)
    else
      render edit_backend_user_path
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to backend_users_url
  end
end
