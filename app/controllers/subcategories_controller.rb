#TODO use inheretedResources
class SubcategoriesController < ApplicationController
  def index
    @subcategories = Subcategory.order('name')
  end

  def new
    @subcategory = Subcategory.new
  end

  def create
    @subcategory = Subcategory.new subcategory_params
    if @subcategory.save
      redirect_to subcategories_path
    else
      render new_subcategory_path
    end
  end

  def edit
    @subcategory = Subcategory.find params[:id]
  end

  def update
    @subcategory = Subcategory.find params[:id]
    if @subcategory.update subcategory_params
      redirect_to subcategories_path
    else
      render edit_subcategory_path
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