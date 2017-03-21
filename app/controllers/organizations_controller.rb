class OrganizationsController < ApplicationController
	before_action :authenticate_user!

    def index
    	if current_user.org_id
    		@organization = Organization.find(current_user.org_id)
    		puts "ORGANIZATION FOUND"
    		puts @organization.inspect
    	else
    		@organization = :null
    		puts "NO ORGANIZATION FOR USER"
    	end
    end

    def show
    	@organization = Organization.find(current_user.org_id)
    	# @apis = @user.apis
    	# @all_apis = Api.all
    	unless current_user.id == @organization.owner_id
        	redirect_to :back, :alert => "Access denied."
    	end
  	end

  	def edit

  	end

    def new
    	@organization = Organization.new
  	end

	def create
		@organization = Organization.new(organization_params)
		@organization.owner_id = current_user.id
		@organization.code = rand(10000..99999)

		puts @organization.inspect
		puts "*********************"

		# might need to remove owner_id from params, but add it here based on current user, and update the user.whatever id
		# Create random code here (might need to take it out of the org params)
		# if they are creating an org, we need to CHANGE THEIR ROLE TO ADMIN and make them the owner
		if @organization.save
			puts "Organization Created"

			current_user.role = 'admin'
			current_user.org_id = @organization.id

			puts "*********************"
			puts @organization.id
			puts @organization.inspect
			puts current_user.inspect
			puts "*********************"
			if current_user.save
				puts "User role updated"
			end

			redirect_to organizations_path, :notice => "Organization created, you are now the Organization Owner."
		else
			puts "ORGANIZATION CREATION FAILED"
			redirect_to organizations_path, :alert => "Unable to create Organization."
		end
	end

	def join
		if !current_user.org_id
			# need to find out how to find org by code, then use org's ID to set current_user.org_id
			@organization = Organization.find_by(code: params[:code])
			if @organization
				current_user.org_id = @organization.id
				current_user.role = 'contractor'
				if current_user.save
					flash[:success] = "Joined Organization"
		      		redirect_to :back
				end
			else
				redirect_to :back, :flash => { :error => "Cannot find Organization" }
			end
		end
	end

	def leave
	    if current_user.org_id
	      current_user.org_id = :null
	      if current_user.save
	      	flash[:success] = "Left Organization"
	      	redirect_to :back
	      end
	    else
	      redirect_to :back, :flash => { :error => "Cannot leave Organization" }
	    end
	end

	def update
		@organization = Organization.find(params[:id])
		if @organization.update_attributes(secure_params)
			redirect_to users_path, :notice => "Organization updated."
		else
			redirect_to users_path, :alert => "Unable to update organization."
		end
	end

	def destroy
		organization = Organization.find(params[:id])
		organization.destroy
		redirect_to users_path, :notice => "Organization deleted."
	end

	private

	def organization_params
		# params.require(:organization).permit(:name, :code, :owner_id, :aws_key, :aws_secret)
		params.require(:organization).permit(:name, :aws_key, :aws_secret, :region, :bucket_name)
	end

	def join_params
		params.require(:user).permit(:code)
	end

	def secure_params
    	params.require(:organization).permit(:name, :aws_key, :aws_secret)
  	end
end
