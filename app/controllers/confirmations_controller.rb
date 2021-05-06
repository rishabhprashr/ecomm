module Api
  class ConfirmationsController < Devise::ConfirmationsController
    skip_before_action :authenticate!

    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      render json: {status: "The emailid is being confirmed. You can login now!!"}
    end
  end
end
