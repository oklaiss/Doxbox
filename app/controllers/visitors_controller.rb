class VisitorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    if @user.contractor?
      # .contains with org id
      @apis = @user.apis.where(org_id: current_user.org_id)
      puts '**********APIS**********'
      puts @apis.inspect
    else
      # .contains with org id
      @apis = Api.all.where(org_id: current_user.org_id)
    end
  end

end
