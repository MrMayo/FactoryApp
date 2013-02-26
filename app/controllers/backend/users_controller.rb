class Backend::UsersController < Backend::ApplicationController
  # def index
  #   @users = User.all
  # end
  # 
  # def show
  #   @user = User.find(params[:id])
  # end
  
  def new
    # @user = User.new
  end
  
  # def edit
  #   @user = User.find(params[:id])
  # end
  # 
  # def create
  #   @user = User.new(params[:backend_user])
  #   if @user.save
  #     redirect_to @user, notice: 'User was successfully created.'
  #   else
  #     render action: "new"
  #   end
  # end
  # 
  # def update
  #   @user = User.find(params[:id])
  #   if @backend_user.update_attributes(params[:backend_user])
  #     redirect_to @backend_user, notice: 'User was successfully updated.'
  #   else
  #     render action: "edit"
  #   end
  # end
  # 
  # def destroy
  #   @backend_user = User.find(params[:id])
  #   @backend_user.destroy
  #   redirect_to backend_users_url
  #   end
  # end
end
