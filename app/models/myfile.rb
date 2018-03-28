class Myfile < ApplicationRecord
  require 'roo'
  attr_accessor :file


#   def self.bulk_upload_xlsx
#     filepath = Myfile.last.filename
#     # filepath = File.absolute_path(Myfile.last.filename)
#     xlsx = Roo::Excelx.new("#{Rails.root}/public/#{filepath}")
#     # workbook = RubyXL::Parser.parse ("#{Rails.root}/public/#{filepath}")
#     header = xlsx.sheet(0).row(1)
#
#
#     xlsx.sheet(0).each do |row|
#       a = row
# binding.pry
#       # sheet.row(1)[0] # 対象のシートの1行目の1列目
#     # headers = worksheet.sheet_data[0]
#     # members = worksheet.get_table(headers)[:table]
#   end

# end
end
