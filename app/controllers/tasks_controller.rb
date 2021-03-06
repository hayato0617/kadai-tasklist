class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が登録されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  
private

def set_task
  @task = Task.find(params[:id])
end  

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end


end