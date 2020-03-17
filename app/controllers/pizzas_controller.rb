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
    @ingredients = Ingredient.all
  end

  def edit
    @sizes = Size.all
    @specialties = Specialty.all
    @ingredients = Ingredient.all
  end

  def create
    @pizza = Pizza.new(pizza_params)
    @pizza.user_id = current_user.id
    @pizza.ingredients = [] unless @pizza.specialty.nil?

    if @pizza.save
      redirect_to user_pizzas_url(current_user),
                  notice: t("labels.pizza_created")
    else
      flash.now[:alert] = @pizza.errors.full_messages
      @sizes = Size.all
      @specialties = Specialty.all
      @ingredients = Ingredient.all
      render :new
    end
  end

  def update
    if @pizza.update(pizza_params)
      @pizza.ingredients = [] unless @pizza.specialty.nil?

      redirect_to user_pizzas_url(current_user),
                  notice: t("labels.pizza_updated")
    else
      flash.now[:alert] = @pizza.errors.full_messages
      @sizes = Size.all
      @specialties = Specialty.all
      @ingredients = Ingredient.all
      render :edit
    end
  end

  def destroy
    @pizza.destroy
    redirect_to user_pizzas_url, notice: t("labels.pizza_destroyed")
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end

  def pizza_params
    params.require(:pizza).permit(
      :name, :description, :specialty_id, :size_id, :user_id, ingredient_ids: []
    )
  end
end
