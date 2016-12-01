require 'aws-sdk'

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => [:show, :apis]

  def index
    @users = User.all
  end

  def apis
    # Aws.config.update({
    #   region: 'us-west-2',
    #   credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["SECRET_ACCESS_KEY"])
    # })
    # # s3 = Aws::S3::Client.new
    # s3_resource = Aws::S3::Resource.new

    # bucket = s3_resource.bucket('api-docs')
    # bucket.objects.each do |obj|
    #   api_set = Api.find_by(api_s3_name: obj.key)
    #   if api_set
    #     api_set.aws_last_updated_at = obj.last_modified
    #     api_set.save
    #   end

    #   puts obj.last_modified
    # end

    @user = current_user
    if @user.contractor?
      @apis = @user.apis
    else
      @apis = Api.all
    end

  end

  def show
    @user = User.find(params[:id])
    @apis = @user.apis
    @all_apis = Api.all
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def add_api
    @api = params[:api]
    @user = params[:user_id]
    ApiUser.create(user_id: @user, api_id: @api)
    flash[:notice] = "User authorized"
    redirect_to :back
  end

  def remove_api
    @api = params[:api]
    @user = params[:user_id]
    api_user = ApiUser.find_by(user_id: @user, api_id: @api)
    if api_user
      api_user.destroy
      flash[:success] = "User access revoked"
      redirect_to :back
    else
      redirect_to :back, :flash => { :error => "Access cannot be revoked" }
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, :notice => "User created."
    else
      redirect_to users_path, :alert => "Unable to create User."
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email)
  end

  def api_params
    params.require(:api).permit(:name, :api_s3_name, :aws_last_updated_at)
  end

  def secure_params
    params.require(:user).permit(:role, :name)
  end

end
