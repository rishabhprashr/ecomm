module Api
    class CartsController < ApplicationController
        # def create
        #     current_user.cart.cart_items.add_item(
        #         product_id: params[:product_id],
        #         quantity: params[:quantity],
        #     )
        #     render json: current_user.cart.cart_items
        # end

        # def index
        #     @carts = Cart.all
        #     render json: @carts
        # end


        # def add
        #     current_user.cart.add_item(cart_params)
        #     render json: current_user.cart, status: 200
        # end

        # def remove
        #     $redis.srem current_user_cart, params[:movie_id]
        #     render json: current_user.cart_count, status: 200
        # end

        # def add_item(product_id:, quantity: 1)
        #     product = Product.find(product_id)
        
        #     order_item = order.items.find_or_initialize_by(
        #       product_id: product_id)
        
        #     order_item.price = product.price
        #     order_item.quantity = quantity
        
        #     order_item.save
        # end

        # private
        # def cart_params
        #     params.permit(:product_id)
        # end

        def show
            cart_items = current_user.cart
            render json: cart_items
        end

       


        
    end
end