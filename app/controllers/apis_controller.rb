require 'aws-sdk'
require 'open-uri'
class ApisController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => [:show]

  def show
    puts "********************************"
    puts current_user
    puts params[:id]
    puts "********************************"

    # ENV VARIABLES MUST BE SET
    #Aws.config.update({
    #  region: 'us-west-2',
    #  credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["SECRET_ACCESS_KEY"])
    #})
    #api_name = Api.find(params[:id]).api_s3_name
    #s3 = Aws::S3::Client.new

    # ADMIN OR USER
    if current_user.role == 'admin' || current_user.role == 'user'
    #  resp = s3.get_object(bucket: 'api-docs', key: api_name)
    #  @url_response = resp.body.read
      render_203
    # UNAUTHORIZED CONTRACTOR
    elsif !current_user.apis.ids.include? params[:id].to_i
      render_401
    # AUTHORIZED CONTRACTOR
    else
    #  resp = s3.get_object(bucket: 'api-docs', key: api_name)
    #   @url_response = resp.body.read
      render_203
    end

    # render :layout => "api"

  end

  def update
    @api = Api.find(params[:id])
    if @api.update_attributes(secure_params)
      redirect_to apis_index_path, :notice => "API updated."
    else
      redirect_to apis_index_path, :alert => "Unable to update API."
    end
  end

  def new
    @api = Api.new
  end

  def create
    @api = Api.new(api_params)
    if @api.save
      redirect_to apis_index_path, :notice => "API Created."
    else
      redirect_to apis_index_path, :alert => "Unable to create API."
    end
  end

  def destroy
    api = Api.find(params[:id])
    api.destroy
    redirect_to apis_index_path, :alert => "API deleted."
  end

  private

  def render_203
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/203", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def render_401
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/401", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def api_params
    params.require(:api).permit(:name, :api_s3_name, :aws_last_updated_at)
  end
end
