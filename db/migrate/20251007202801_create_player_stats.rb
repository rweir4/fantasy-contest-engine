class CreatePlayerStats < ActiveRecord::Migration[8.0]
  def change
    create_table :player_stats do |t|
      t.references :player, foreign_key: true, null: false
      t.integer :game_week, null: false
      t.jsonb :stats, null: false
      t.decimal :fantasy_points, null: false

      t.timestamps
    end
  end
end
