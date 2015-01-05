#TODO use inheretedResources
class CategoriesController < ApplicationController

  PER_PAGE = 20

  def index
    @categories = Category.order('name').page(params[:page]).per PER_PAGE
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to categories_path, alert: t(:flash_notice)
    else
      render new_category_path, alert: t(:flash_alert)
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update category_params
      redirect_to categories_path, alert: t(:flash_notice)
    else
      render edit_category_path, alert: t(:flash_alert)
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to categories_path
  end

private

  def category_params
    params.require(:category).permit(:name)
  end
end
