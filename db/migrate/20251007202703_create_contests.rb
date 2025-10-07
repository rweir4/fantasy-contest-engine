class CreateContests < ActiveRecord::Migration[8.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.decimal :entry
      t.integer :salary_cap
      t.datetime :start_time
      t.string :status
      t.integer :cached_leader_id

      t.timestamps
    end
  end
end
