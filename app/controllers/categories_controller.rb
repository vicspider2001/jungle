module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate

    def index
      @categories = Category.order(id: :desc).all
    end

    def show
      @category = Category.find(params[:id])
      @products = @category.products.order(created_at: :desc)
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories_path, notice: 'Category created!'
      else
        render :new
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: 'Category updated!'
      else
        render :edit
      end
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      redirect_to admin_categories_path, notice: 'Category deleted!'
    end

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
      end
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
