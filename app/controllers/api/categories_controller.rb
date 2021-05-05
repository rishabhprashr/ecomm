module Api
  class CategoriesController < ApplicationController
    skip_before_action :authenticate!, only: [:index]
    
    def index
      records = Category.all
      render json: records
    end

    def show
      category = Category.where(name: params[:name])
      if category.nil? || category.blank?
        render json:{success: false, message:"Not found."}, status: :bad_request
      else
        render json: {success: true, category: category}, status: :ok
      end
      
    end
    
  end
end
