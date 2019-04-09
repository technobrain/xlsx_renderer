class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  def index
    @report_title = "Ruby テストレポート"
    @todos = Todo.all
    
    respond_to do |format|
      format.html { render action: :index }
      format.xlsx do
        json = @todos.as_json
        @data = json.map do |record|
          record.tap do |rec|
            rec['completed_at'] = rec['completed_at'].localtime.strftime('%Y/%m/%d %H:%M')
            rec['created_at'] = rec['created_at'].strftime('%Y/%m/%d %H:%M')
            rec['updated_at'] = rec['updated_at'].strftime('%Y/%m/%d %H:%M')
          end
        end
          
        template = "todo_list.xlsx"
        send_data XlsxRenderer.generate_xlsx(template, view_context),
                  filename: "export_#{Time.zone.today}.xlsx"
      end
    end
  end

  # GET 
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: 'Todo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'Todo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    redirect_to todos_url, notice: 'Todo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_params
      params.require(:todo).permit(:title, :content, :due_date, :completed_at)
    end
end
