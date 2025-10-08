class CreateContests < ActiveRecord::Migration[8.0]
  def change
    create_table :contests do |t|
      t.string :name, null: false
      t.decimal :entry, null: false
      t.integer :salary_cap, null: false
      t.datetime :start_time, null: false
      t.string :status, null: false
      t.integer :cached_leader_id

      t.timestamps
    end
  end
end
