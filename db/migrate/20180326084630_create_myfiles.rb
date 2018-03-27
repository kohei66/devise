class CreateMyfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :myfiles do |t|
      t.string :filename
      t.timestamps
    end
  end
end
