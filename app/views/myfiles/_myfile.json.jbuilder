json.extract! myfile, :id, :title, :filename, :comment, :created_at, :updated_at
json.url myfile_url(myfile, format: :json)
