class Admin::DashboardController < ApplicationController
  before_filter :authenticate
  
  def show
    @product_count = Product.count
    @category_list = Product.group(:category_id).count
  end
end
