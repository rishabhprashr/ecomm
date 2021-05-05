module Api
  class  UsersController < ApplicationController


    def create
      # token = SecureRandom.urlsafe_base64(100)
      user = User.new(name: params[:name],
        email: params[:email],
        password: params[:password]
        # token: token, 
        # token_created_at: Time.now)
      if user.save
        render json: {
          success: true,
          user: { 
            name: user.name,
            email: user.email,
            # token: user.token,
            # created_at: user.token_created_at
          }
        }, status: :ok
      else
        render json: {success: false,errors: user.errors}, status: :bad_request and return
      end
    end

  end
end

