# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(user_id: current_user.id)
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    @order.total = @order.sub_total
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to user_order_path(current_user, @order)
  end

  private

  def order_params
    params.require(:order).permit(:name, :email)
  end
end
