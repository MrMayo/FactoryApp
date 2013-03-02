class Backend::UsersController < Backend::ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy]

  def index
    @users = User.order(:id).page(params[:page])
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
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      sign_in @user
      redirect_to backend_user_path(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'User destroyed.'
    redirect_to backend_users_path
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in"
        redirect_to backend_signin_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(backend_root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(backend_root_path) unless current_user.admin?
    end

end
