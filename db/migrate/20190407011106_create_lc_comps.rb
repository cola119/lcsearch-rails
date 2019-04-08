class CreateLcComps < ActiveRecord::Migration[5.2]
  def change
    create_table :lc_comps, id: false do |t|
			t.column :id, 'INTEGER PRIMARY KEY NOT NULL'
      t.string :name
      t.date :date
      t.string :terrain
      t.string :owner
      t.text :link
      t.text :lc_link

      t.timestamps
    end
  end
end
