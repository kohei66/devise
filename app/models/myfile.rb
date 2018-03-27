class Myfile < ApplicationRecord
    require 'rubyXL'
  attr_accessor :file


  def self.bulk_upload_xlsx
    filepath = Myfile.last.filename
    # filepath = File.absolute_path(Myfile.last.filename)
    workbook = RubyXL::Parser.parse ("#{Rails.root}/public/#{filepath}")
    binding.pry



    worksheet = workbook[0]
    headers = worksheet.extract_data[0]
    members = worksheet.get_table(headers)[:table]
  end


end
