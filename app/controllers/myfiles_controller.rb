class MyfilesController < ApplicationController
  before_action :set_myfile, only: %i[show edit update destroy]

  # GET /myfiles
  # GET /myfiles.json
  def index
    @myfiles = Myfile.all
  end

  # GET /myfiles/1
  # GET /myfiles/1.json
  def show; end

  # GET /myfiles/new
  def new
    @myfile = Myfile.new
  end

  # GET /myfiles/1/edit
  def edit; end

  # POST /myfiles
  # POST /myfiles.json
  def create
    @myfile = Myfile.new(myfile_params)

    file = myfile_params[:file]
    file_name = file.original_filename
    @myfile.filename = file.original_filename
    result = uploadxlsx(file, file_name)

    respond_to do |format|
      if result == 'success' && @myfile.save
        format.html { redirect_to @myfile, notice: 'Myfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @myfile }
      else
        deletexlsx(file_name)
        format.html { render action: 'new' }
        format.json { render json: @myfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /myfiles/1
  # PATCH/PUT /myfiles/1.json
  def update
    respond_to do |format|
      if @myfile.update(myfile_params)
        format.html { redirect_to @myfile, notice: 'Myfile was successfully updated.' }
        format.json { render :show, status: :ok, location: @myfile }
      else
        format.html { render :edit }
        format.json { render json: @myfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myfiles/1
  # DELETE /myfiles/1.json
  def destroy
    @myfile.destroy
    respond_to do |format|
      format.html { redirect_to myfiles_url, notice: 'Myfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def open_spreadsheet(myfile_params)
    if File.extname(myfile_params.original_filename) == '.xlsx'
      RubyXL::Parser.parse(myfile_params.path)
    else
      false
    end
  end

  def bulk_upload
    id = params[:excel_id].to_i
    filepath = Myfile.find(id).filename
    xlsx = Roo::Excelx.new("#{Rails.root}/public/#{filepath}")
    header = xlsx.sheet(0).row(1)

    xlsx.sheet(0).each_with_index do |row,i|
      next if i == 0
      header_row_pairs = [header.collect(&:to_sym), row].transpose
      h = Hash[*header_row_pairs.flatten]
      h.delete(:id)
      Blog.create(h)
      end

    redirect_to blogs_path, notice: "一括アップロード実施いたしました"
  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_myfile
    @myfile = Myfile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def myfile_params
    params.require(:myfile).permit(:file,:excel_id)
  end

  def uploadxlsx(file_object, file_name)
    ext = file_name[file_name.rindex('.') + 1, 4].downcase
    perms = ['.xlsx']
    if !perms.include?(File.extname(file_name).downcase)
      result = 'アップロードできるのはxlsxファイルのみです。'
    elsif file_object.size > 10.megabyte
      result = 'ファイルサイズは10MBまでです。'
    else
      File.open("public/#{file_name.toutf8}", 'wb') { |f| f.write(file_object.read) }
      result = 'success'
    end
    result
end

  def deletexlsx(file_name)
    File.unlink 'public/' + file_name.toutf8
end
end
