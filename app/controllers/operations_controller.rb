class OperationsController < ApplicationController

  PER_PAGE = 10

  def index
    if params.key? :filter
      @operations = Operation.get_by params[:filter]
    else
      @operations = Operation.order('date')
    end
    @operations = @operations.page(params[:page]).per PER_PAGE
  end

  def new
    @operation = Operation.new
    build_variables
  end

  def create
    @operation = Operation.new operation_params
    if @operation.save
      redirect_to operations_path, notice: t(:flash_notice)
    else
      render new_operation_path, alert: t(:flash_alert)
    end
  end

  def edit
    @operation = Operation.find params[:id]
    build_variables
  end

  def update
    @operation = Operation.find params[:id]
    if @operation.update operation_params
      redirect_to operations_path, notice: t(:flash_notice)
    else
      render edit_operation_path, alert: t(:flash_alert)
    end
  end

  def destroy
    @operation = Operation.find params[:id]
    @operation.destroy
    redirect_to operations_path
  end

  #TODO sepatare controller for selects
  def fill_subcategory
    @select_data = Subcategory.get_select_data params[:category_id]
    respond_to do |format|
      format.json {render}
    end
  end

  def list_filter
    build_variables
  end

private

  #TODO learn best practice with adding assocations
  def operation_params
    params.require(:operation)
      .permit(:date,
              :sum,
              :source,
              :category_id,
              :subcategory_id,
              :comment)
  end

  def build_variables
    @categories = Category.get_select_data
    if @categories.blank?
      @subcategories = []
    else
      @subcategories = Subcategory.get_select_data(@categories[0][1])
    end
  end
end
