module Api
  class OrdersController < ApplicationController
    def index
      orders = current_user.orders.includes(:order_items)
      data = []

      orders.each do |order|
        data << order.format
      end

      render json: data
    end

    def show
      order = current_user.orders.find params[:id]
      render json: order.format
    end
    
    def create
      order = current_user.create_order!

      if order.errors.blank?
        render json: {
                 success: true,
                 order: order.format
               }, status: :ok
      else
        render json: {
                 success: false,
                 errors: order.errors
               }, status: :bad_request
      end
      
    end
  end
end