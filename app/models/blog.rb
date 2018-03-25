class Blog < ApplicationRecord
  require 'rubyXL'

  enum status: { 承認待ち: 0, 否決済み: 1, 承認済み: 2 }
  belongs_to :user


  FILTER_BUTTON_WIDTH = 2
  MAX_COL_WIDTH = 30

  def self.export_xlsx()
    workbook = RubyXL::Workbook.new
worksheet = workbook[0]

# contents = Blog.all
blog = Blog.all
# Contents.
contents = [
    ['column_A', 'column_B', 'column_C'],
    [100, 200, 300],
    ['value_a', 'too long string', 'long long string over than default column width'],
]


column_width = [0, 0, 0]

# Add cells.
contents.each.with_index { |values, row|
  values.each.with_index { |value, column|
    # Add.
    cell = worksheet.add_cell(row, column, value)

    # Header line.
    if row == 0
      cell.change_fill('808080')
      cell.change_font_color('FFFFFF')
    end

    # Column width.
    column_width[column] = value.to_s.size if column_width[column] < value.to_s.size
  }
}




# Column width.
column_width.each.with_index { |width, column|
  rounded = width + FILTER_BUTTON_WIDTH
  rounded = MAX_COL_WIDTH if rounded > MAX_COL_WIDTH
  worksheet.change_column_width(column, rounded)
}

# Set filter.
range = RubyXL::Reference.new(0, 0, 0, 2) # row from/to, col from/to
filter = RubyXL:: AutoFilter.new
filter.ref = range
worksheet.auto_filter = filter

# Output.
workbook.write("#{Rails.root}/tmp/distributor.xlsx")



end
end
