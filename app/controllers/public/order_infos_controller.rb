class Public::OrderInfosController < ApplicationController
  before_action :move_to_signed_in
  
  def new
  end

  def index
  end

  def show
  end

  def create
  end

  def confirm
  end

  def complete
  end
  
  private
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/customers/sign_in'
    end
  end
end
