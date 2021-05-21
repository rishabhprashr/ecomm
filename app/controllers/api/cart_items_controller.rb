module Api
  class CartItemsController < ApplicationController
    before_action :get_cart_item, only: [:update, :destroy]
    
    def index
      cart_items = current_user.cart_items.includes(:product)

      data = []
      totalPrice = 0
      cart_items.each do |cart_item|
        data << cart_item.format
        totalPrice += cart_item.quantity * cart_item.product.price
      end
      render json: {success: true,data:data,totalPrice:totalPrice}
    end
    
    def create
      cart_item = current_user.basket.cart_items.new(
        product_id: params[:product_id],
        quantity: params[:quantity]
      )
      
      if cart_item.save
        render json: {
          success: true,
          cart_item: cart_item.format
        }, status: :ok
      else
        render json: {
          success: false,
          errors: cart_item.errors
        }, status: :bad_request
      end
    end

    def update
      if @cart_item.update(quantity: params[:quantity])
        index
      else
        render json: {
          success: false,
          errors: @cart_item.errors
        }, status: :bad_request
      end
    end

    def destroy
      @cart_item.destroy

      data= index

      # render json: {
      #   success: true,
      #   cart_item: @cart_item.format
      # }
    end

    def get_cart_item
      @cart_item = current_user.cart_items.find params[:id]
    rescue ActiveRecord::RecordNotFound
      render json: {success: false, error: "Not found"},
              status: :not_found and return
    end
    
  end
end