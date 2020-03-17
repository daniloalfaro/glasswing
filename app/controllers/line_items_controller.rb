# frozen_string_literal: true

class LineItemsController < ApplicationController
  def create
    # Find associated pizza and current cart
    chosen_pizza = Pizza.find(params[:pizza_id])
    current_cart = @current_cart

    # If cart already has this pizza then find the relevant line_item and
    # iterate quantity otherwise create a new line_item for this pizza
    if current_cart.pizzas.include?(chosen_pizza)
      # Find the line_item with the chosen_pizza
      @line_item = current_cart.line_items.find_by(pizza_id: chosen_pizza)
      # Iterate the line_item's quantity by one
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.pizza = chosen_pizza
    end

    # Save and redirect to cart show path
    @line_item.save
    redirect_to user_cart_path(current_user, current_cart)
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to user_cart_path(@current_cart)
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to user_cart_path(@current_cart)
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity -= 1 if @line_item.quantity > 1
    @line_item.save
    redirect_to user_cart_path(@current_cart)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :pizza_id, :cart_id)
  end
end
