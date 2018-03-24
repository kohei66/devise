class AddColumnToBlog < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :status, :integer, default: 0
    add_column :blogs, :user_id, :integer
    add_column :blogs, :remark, :text
  end
end
