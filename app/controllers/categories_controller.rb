#TODO use inheretedResources
class CategoriesController < ApplicationController

  PER_PAGE = 20

  def index
    @categories = Category.ordered_by_user(current_user).page(params[:page]).per PER_PAGE
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.user = current_user
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
