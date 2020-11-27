class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @categories = Category.all
    @tags = Tag.all

    if params[:search]
      @categ = params[:search][:categories].present? ? params[:search][:categories] : @categories.pluck(:id)
      @ta =  params[:search][:tags].flatten.reject(&:blank?).present? ? params[:search][:tags].flatten.reject(&:blank?) :  Tag.pluck(:id)
      if params[:search][:categories].blank? && params[:search][:tags].flatten.reject(&:blank?).blank?
        @tasks = current_user.tasks.paginate(page: params[:page], per_page: 30).where("title like ?", "%#{params['search']['search']}%").includes(:category).order(:deadline_at)
      else
        @tasks = current_user.tasks.paginate(page: params[:page], per_page: 30).where("title like ?", "%#{params['search']['search']}%").where(category_id: @categ).includes(:category).joins(:tag_associations).where(tag_associations: {tag_id: @ta}).order(:deadline_at)
      end
    else
      @tasks = current_user.tasks.paginate(page: params[:page], per_page: 30).includes(:category).order(:deadline_at)
    end

  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.tag_associations.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json

  def create

    @task = Task.new(task_params.merge(user:current_user))

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    change_params
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end
  def change_params
    if params['task']['tag_associations_attributes'].present?
    params['task']['tag_associations_attributes'].to_enum.to_h.each do |h|
      if h.last.key?('tag_id')
      else
        h.last.merge!('_destroy' => '1')
      end
    end
    end
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:id, :deadline_at, :title, :note, :is_done, :category_id, tag_associations_attributes: [:id, :tag_id, :_destroy])    end
end
