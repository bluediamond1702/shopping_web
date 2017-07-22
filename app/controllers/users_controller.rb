class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: [:index, :destroy]
  before_action :set_user,        only: [:show, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to rootpath unless current_user == @user
  end
end
