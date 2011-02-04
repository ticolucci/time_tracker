class TasksController < ApplicationController
  before_filter :login_required
  
  def index
    @tasks = Task.all
    @begin_sheet_date = Date.civil(Date.today.year, Date.today.month)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:notice] = "Successfully created task."
      redirect_to tasks_url
    else
      render :action => 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = "Successfully updated task."
      redirect_to tasks_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Successfully destroyed task."
    redirect_to tasks_url
  end
  
  def time_sheet
    @from_date = Date.civil params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i
    @user = current_user
    @tasks = @user.tasks.select {|t| t.entries.detect {|e| e.begin >= @from_date} }
  end
end
