class Public::Base < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about, :search]
end