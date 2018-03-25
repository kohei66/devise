class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  # GET /blogs
  # GET /blogs.json
  def index
    if params[:status]
      @blogs = Blog.where(status: params[:status])
    else
      @blogs = Blog.all
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.new(blog_params)
    respond_to do |format|
      if @blog.save!
        NotificationMailer.notification_mail(@blog).deliver
        ContactMailer.contact_mail(@blog).deliver
        format.html { redirect_to @blog, notice: '申請の受付が完了いたしました。' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: '申請の修正が完了いたしました' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: '申請の取り消しが完了いたしました。' }
      format.json { head :no_content }
    end
  end

  def export_xlsx
    Blog.export_xlsx()
    send_file("#{Rails.root}/tmp/distributor.xlsx")
    redirect_to blogs_url, notice: 'excelのダウンロードが完了いたしました。'
    @blog = current_user
    ExcelMailer.excel_mail(@blog).deliver
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content, :status)
    end
end
