module Api
  class ProductsController < ApplicationController
    # skip_before_action :authenticate!, only: [:index]
    before_action :fetch_category, only: [:show, :index]
    
    def index
      # products = @category.products.limit(params[:limit]).offset(params[:offset])
      # products = @category.products.paginate(page: params[:page], per_page: 20)
      # render json:{success: true,products: products},status: :ok 
      data = @category.products
      
      if params[:search]
        data = data.where("name like :search", search: "%#{params[:search]}%")
      end

      pagy, products = pagy data
      
      result = pagy.vars.slice(:page, :items, :count)
      result[:data] = products
      
      render json: result
    end

    def show
      
        
    
      @category = Category.find params[:category_id]
      product = @category.products
                  .where(id: params[:id]).first
      
      if !(product.nil? || product.blank?)
        data = product.attributes.symbolize_keys
        data.delete(:category_id)
        data.merge!(category: {
                      id: @category.id,
                      name: @category.name
                    })
        render json:{success: true, data: data},status: :ok and return
      else
        render json:{success: false,error: "Item not found"},status: :not_found and return
      end
    end

    def search
      search = params[:name]
      category = Category.where(name: params[:name]).first
      if !(category.nil? || category.blank?)
        products = Product.where(category_id: category.id)
      else
        products = Product.where("name like :search", search: "%#{search}%")
      end

      pagy, products = pagy products
      
      result = pagy.vars.slice(:page, :items, :count)
      result[:data] = products
      render json: {success: true, products: result}, status: :ok and return

    end
    

    private

    
    def fetch_category
      @category = Category.find params[:category_id]
    end
  end
end
