module Api
  class ProductsController < ApplicationController
    skip_before_action :authenticate!, only: [:index]
    before_action :fetch_category
    
    def index
      products = @category.products
      render json: products
    end

    def show
      product = @category.products
                  .where(id: params[:id]).first

      data = product.attributes.symbolize_keys
      data.delete(:category_id)
      data.merge!(category: {
                    id: @category.id,
                    name: @category.name
                  })
      
      render json: data and return
    end

    def show
      product = Products.where(name: params[:name])
      if product.nil? || product.blank?
        render json:{success: false, message:"Not found."}, status: :bad_request
      else
        render json: {success: true, product: product}, status: :ok
      end
      
    end

    private

    
    def fetch_category
      @category = Category.find params[:category_id]
    end
  end
end
