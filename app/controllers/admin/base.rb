class Admin::Base < ApplicationController
  before_action :authenticate_admin!, except: [:top, :about]
end