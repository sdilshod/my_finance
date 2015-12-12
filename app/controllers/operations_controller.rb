class OperationsController < ApplicationController

  respond_to :json, only: :fill_subcategory

  PER_PAGE = 10

  def index
    @filter_string = ''
    if params.key? :filter
      @operations, @filter_string = Operation.get_by current_user.id, params[:filter]
    else
      @operations = current_user.operations.order('date desc')
    end
    @calculations = build_calculation_hash
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
    @select_data = Subcategory.ordered_by_category params[:category_id]
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
    @categories = Category.ordered_by_user current_user
    if @categories.size == 0
      @subcategories = []
    else
      @subcategories = Subcategory.ordered_by_category(category_id.blank? ? @categories.first.id : category_id)
    end
  end

  def build_calculation_hash
    incoming_cash_sum = @operations.where('sum > 0 and source = 1').sum(:sum).to_f
    incoming_plastic_sum = @operations.where('sum > 0 and source = 2').sum(:sum).to_f

    expense_cash_sum = @operations.where('sum < 0 and source = 1').sum(:sum).to_f
    expense_plastic_sum = @operations.where('sum < 0 and source = 2').sum(:sum).to_f

    h = {
          incoming: incoming_cash_sum + incoming_plastic_sum,
          expense: expense_cash_sum + expense_plastic_sum,
          incoming_details: { cash:  incoming_cash_sum, card: incoming_plastic_sum },
          expense_details: { cash:  expense_cash_sum, card: expense_plastic_sum}
        }
    return h
  end

end
