class CreateLcResults < ActiveRecord::Migration[5.2]
  def change
    create_table :lc_results do |t|
      t.integer :lc_class_id
      t.string :name
      t.integer :runner_id
      t.string :ecard
      t.string :club
      t.string :start
      t.string :result
      t.string :rank
      t.string :speed
      t.string :loss_rate
      t.string :total_relative
      t.string :total_losstime
      t.string :ideal_time

      t.timestamps
    end
  end
end
