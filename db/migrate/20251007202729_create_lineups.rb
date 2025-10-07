class CreateLineups < ActiveRecord::Migration[8.0]
  def change
    create_table :lineups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contest, null: false, foreign_key: true
      t.decimal :total_score

      t.timestamps
    end
  end
end
