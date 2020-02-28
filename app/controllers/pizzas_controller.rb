# frozen_string_literal: true

class PizzasController < ApplicationController
  before_action :authenticate_user!

  before_action :set_pizza, only: %i[show edit update destroy]

  def index
    @pizzas = Pizza.where(user_id: current_user)
  end

  def show; end

  def new
    @pizza = Pizza.new
    @sizes = Size.all
    @specialties = Specialty.all
  end

  def edit; end

  def create
    @pizza = Pizza.new(pizza_params)
    @pizza.user_id = current_user.id

    if @pizza.save
      redirect_to user_pizzas_url(current_user),
        notice: 'Pizza was successfully created.'
    else
      puts "====================================> #{@pizza.errors.full_messages}"
      flash.now[:alert] = @pizza.errors.full_messages
      @sizes = Size.all
      @specialties = Specialty.all
      render :new
    end
  end

  def update
    respond_to do |format|
      if @pizza.update(pizza_params)
        format.html do
          redirect_to @pizza, notice: 'Pizza was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pizza.destroy
    redirect_to pizzas_url, notice: 'Pizza was successfully destroyed.'
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end

  def pizza_params
    params.require(:pizza).permit(
      :name, :description, :specialty_id, :size_id, :user_id)
  end
end
