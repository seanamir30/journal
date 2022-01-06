class TasksController < ApplicationController
	before_action :get_category

  # GET /tasks or /tasks.json
  def index
    @tasks = @category.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @category.tasks.build
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks or /tasks.json
  def create
    @task = @category.tasks.build(task_params)
    @task.category = @category
	  if @task.save
	  	redirect_to categories_url
	  else
	  	render :new
	  end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      @task = Task.find(params[:id])
      if @task.update(task_params)
        format.html { redirect_to categories_url, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task ? @task.destroy : Task.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_category
      @category = Category.find(params[:category_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :category_id, :due_date)
    end
end
