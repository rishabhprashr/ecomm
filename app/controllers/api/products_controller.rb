module Api
  class ProductsController < ApplicationController
    skip_before_action :authenticate!, only: [:index]
    before_action :fetch_category, only: [:show, :index]
    
    def index
      products = @category.products.limit(20).offset(params[:offset])
      render json:{success: true,products: products},status: :ok 
    end

    def show
      
        
    
      @category = Category.find params[:category_id]
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

    def search
      products = Product.where(name: params[:name]).first
      if products.nil? || products.blank?
        render json:{success: false, message:"Not found product."}, status: :bad_request
      else
        render json: {success: true, products: products}, status: :ok
      end
      
      
    end
    

    private

    
    def fetch_category
      @category = Category.find params[:category_id]
    end
  end
end
