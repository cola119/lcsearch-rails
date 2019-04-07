class CreateLcComps < ActiveRecord::Migration[5.2]
  def change
    create_table :lc_comps do |t|
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
