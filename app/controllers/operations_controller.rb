class OperationsController < ApplicationController

  def index
    @operations = Operation.order('date')
  end

  def new
    @operation = Operation.new
  end

  def create
    @operation = Operation.new operation_params
    if @operation.save
      redirect_to operations_path
    else
      render new_operation_path
    end
  end

  def edit
    @operation = Operation.find params[:id]
  end

  def update
    @operation = Operation.find params[:id]
    if @operation.update operation_params
      redirect_to operations_path
    else
      render edit_operation_path
    end

  end

  def destroy
    @operation = Operation.find params[:id]
    @operation.destroy
    redirect_to operations_path
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
end
