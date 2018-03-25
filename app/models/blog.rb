class Blog < ApplicationRecord
  require 'rubyXL'

  enum status: { 承認待ち: 0, 否決済み: 1, 承認済み: 2 }
  belongs_to :user


  # FILTER_BUTTON_WIDTH = 2
  # MAX_COL_WIDTH = 30

def self.export_xlsx
  workbook = RubyXL::Workbook.new
  worksheet = workbook[0]

  all_distributor_list = Blog.all
  column_names = Blog.attribute_names
  contents = []
  contents << column_names
  @distributor_info = []
  all_distributor_list.each do |distributor_record|
    column_names.each do |column_name|
      @distributor_info << distributor_record.send(column_name)
    end
    contents << @distributor_info
      @distributor_info = []
  end

  # Add cells.
  contents.each.with_index do |values, row|
    values.each.with_index do |value, column|
      # Add.
      cell = worksheet.add_cell(row, column, value)

      # Header line.
      if row == 0
        cell.change_fill('808080')
        cell.change_font_color('FFFFFF')
      end

      # Column width.
      # column_width[column] = value.to_s.size if column_width[column] < value.to_s.size
    end
  end

  #各カラムの幅を20にする
  columnu_number = 0
  contents[0].each do |_column_names|
    worksheet.change_column_width(columnu_number, 20)
    columnu_number += 1
  end

  # Column width.
  # column_width.each.with_index { |width, column|
  #   rounded = width + FILTER_BUTTON_WIDTH
  #   rounded = MAX_COL_WIDTH if rounded > MAX_COL_WIDTH
  #   worksheet.change_column_width(column, rounded)
  # }

  # # Set filter.
  # range = RubyXL::Reference.new(0, 0, 0, 2) # row from/to, col from/to
  # filter = RubyXL:: AutoFilter.new
  # filter.ref = range
  # worksheet.auto_filter = filter

  # Output.
  workbook.write("#{Rails.root}/tmp/distributor.xlsx")
end

end
