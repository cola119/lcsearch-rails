class CreateLcClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :lc_classes do |t|
      t.integer :lc_comp_id
      t.string :class_name
      t.float :length
      t.float :climb
      t.integer :controls
      t.string :course
      t.string :filename
      t.integer :file_id
      t.integer :participants

      t.timestamps
    end
  end
end
