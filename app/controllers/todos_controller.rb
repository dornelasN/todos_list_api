class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.all
    json_response(@todos)
  end

  # POST /todos
  def create
    # create! raises an exception ActiveRecord::RecordInvalid, avoiding nested
    # if statements in the controller. This exception is recued in the
    # ExceptionHandler module
    @todo = Todo.create!(todo_params)
    json_response(@todo, :created)
  end

  # GET /todos/:id
  def show
    json_response(@todo)
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  # Find the todo that will be showed, updated, or destroyed before the action
  def set_todo
    @todo = Todo.find(params[:id])
  end
end
