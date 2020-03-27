# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  before_action :current_cart

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.superadmin?
      #flash[:alert] = 'Unauthorized Access!'
      redirect_to root_path
    end
  end

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id].nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end
end
