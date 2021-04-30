module Api
  class OrdersController < ApplicationController

    def index
      orders = current_user.orders.where(user_id:current_user.id)
      render json: orders
    end

    def show
      current_user_orders = Order.where(user_id: current_user.id)
      order = curent_user_orders.where(id:params[:id]).first
      if order
        render json: order.order_items
      else
        render json: {status: "No order found with given id"}
      end
    end

    def create
      items = current_user.cart.cart_items
      order = Order.create(user_id:current_user.id,invoice_number: rand(1000...100000))
      order_items = items.each do |item|
        order.order_items.create(product_id: item.product_id,
          quantity: item.quantity)
      end
      render json: order_items
    end


  end