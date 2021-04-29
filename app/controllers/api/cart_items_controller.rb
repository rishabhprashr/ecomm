module Api
    class CartItemsController < ApplicationController

        def create
            user_cart=current_user.cart
            add_quantity=params[:quantity].to_i
            product = user_cart.cart_items.where(product_id: params[:product_id])
            if product.exists?
                product.first.update( quantity: params[:quantity])
                render json: {status: "The quantity of this particular product is being increased"} and return
            else
                add_item_to_cart = user_cart.cart_items.create(
                    product_id:params[:product_id],
                    quantity: params[:quantity]
                )
            end

            render json: add_item_to_cart
        end

        def show
            # cart_items=@cart.cart_items.find.where(id: params[:id]).first
            # cart_id=current_user.cart.id
            # cart_item = CartItem.where({cart_id:cart_id})
            # cart_item = CartItem.find_by(id:params[:id])
            # data=cart_item.attributes.symbolize_keys
            # data.delete(:cart_id)


            # # render json: cart_item
            # render json: data and return
        end

        def destroy
            # cart_items=current_user.cart.cart_items.find_by(id: params[:id])
            # cart_items.destroy
            @cart_item=CartItem.find_all_by_id(:cart_id)
            @cart_item.destroy
        end

    end
end