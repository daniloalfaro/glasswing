# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index; end
end
