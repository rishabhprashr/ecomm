module Api
  class ProductsController < ApplicationController
    # skip_before_action :authenticate!, only: [:index]
    before_action :fetch_category, only: [:show, :index]
    
    def index
      products = @category.products.limit(params[:limit]).offset(params[:offset])
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
        category = Category.where(name: params[:name]).first
        if !(category.nil? || category.blank?)
          product = Product.where(category_id: category.id)

          render json:  { success: true, products: product}, status: :ok and return
        end
      else
        render json: {success: true, products: products}, status: :ok and return
      end

      render json: {success: false, error: "Not found"}, status: :not_found and return
      
      
    end
    

    private

    
    def fetch_category
      @category = Category.find params[:category_id]
    end
  end
end
