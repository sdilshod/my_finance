#TODO use inheretedResources
class SubcategoriesController < ApplicationController

  PER_PAGE = 20

  def index
    @subcategories = current_user.subcategories.order('name').page(params[:page]).per PER_PAGE
  end

  def new
    @categories = Category.ordered_by_user(current_user)
    @subcategory = Subcategory.new
  end

  def create
    @subcategory = Subcategory.new subcategory_params
    if @subcategory.save
      redirect_to subcategories_path, alert: t(:flash_notice)
    else
      render new_subcategory_path, alert: t(:flash_alert)
    end
  end

  def edit
    @subcategory = Subcategory.find params[:id]
    @categories = Category.ordered_by_user(current_user)
  end

  def update
    @subcategory = Subcategory.find params[:id]
    if @subcategory.update subcategory_params
      redirect_to subcategories_path, alert: t(:flash_notice)
    else
      render edit_subcategory_path, alert: t(:flash_alert)
    end
  end

  def destroy
    @subcategory = Subcategory.find params[:id]
    @subcategory.destroy
    redirect_to subcategories_path
  end

private

  #TODO learn best practice with adding assocations
  def subcategory_params
    params.require(:subcategory).permit(:name, :category_id)
  end
end
