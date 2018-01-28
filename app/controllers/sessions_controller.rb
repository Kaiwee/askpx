class SessionsController < ApplicationController
	
	def create_from_omniauth
	    auth_hash = request.env["omniauth.auth"]

	    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
		    # if: previously already logged in with OAuth
		    if authentication.user
		      user = authentication.user 
		      authentication.update_token(auth_hash)
		      @next = root_path
		      @notice = "Signed in!"
		    # else: user logs in with OAuth for the first time  
		    else
		      user = User.create_with_auth_and_hash(authentication, auth_hash)
		      # you are expected to have a path that leads to a page for editing user details
		      @next = root_path 
		      @notice = "User created - confirm or edit details..."
		    end

	    	if params[:remember_me]
      			cookies.permanent[:auth_token] = user.auth_token
      		else
      			cookies[:auth_token] = user.auth_token
      		end
	    redirect_to @next, :notice => @notice
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			if params[:user][:remember_me]
      			cookies.permanent[:auth_token] = @user.auth_token
      		else
      			cookies[:auth_token] = @user.auth_token
      		end

      		redirect_to '/', :notice => "Sign up successfully"
		else
			redirect_to '/sign_up', :notice => "Please try sign up again and fill in all details correctly"
		end	
	end

	def destroy
		cookies.delete(:auth_token)
		redirect_to '/sign_in', :notice => "You have been signed out"
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :phone, :intro, :city, :state, :country, :role, :avatar, :remove_avatar, {documents: []}, :remove_documents)
	end
end
