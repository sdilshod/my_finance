class OperationsController < ApplicationController

  PER_PAGE = 10

  def index
    @filter_string = ''
    if params.key? :filter
      @operations, @filter_string = Operation.get_by current_user.id, params[:filter]
    else
      @operations = current_user.operations.order('date desc')
    end
    @calculations = {
                      incoming: @operations.where('sum > 0').sum(:sum).to_f,
                      expense: @operations.where('sum < 0').sum(:sum).to_f
                    }
    @operations = @operations.page(params[:page]).per PER_PAGE
  end

  def new
    @operation = Operation.new
    build_variables
  end

  def create
    @operation = Operation.new operation_params
    @operation.user = current_user
    if @operation.save
      redirect_to operations_path, notice: t(:flash_notice)
    else
      build_variables
      render :new
    end
  end

  def edit
    @operation = Operation.find params[:id]
    build_variables @operation.category_id
  end

  def update
    @operation = Operation.find params[:id]
    if @operation.update operation_params
      redirect_to operations_path, notice: t(:flash_notice)
    else
      build_variables @operation.category_id
      render :edit
    end
  end

  def destroy
    @operation = Operation.find params[:id]
    @operation.destroy
    redirect_to operations_path
  end

  #TODO sepatare controller for selects
  def fill_subcategory
    @select_data = Subcategory.get_select_data params[:category_id], params.key?(:filter_action)
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

  def build_variables category_id = nil
    @categories = Category.get_select_data current_user
    if @categories.blank?
      @subcategories = []
    else
      @subcategories = Subcategory.get_select_data(category_id.blank? ? @categories[0][1] : category_id)
    end
  end
end
