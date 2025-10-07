class CreatePlayerStats < ActiveRecord::Migration[8.0]
  def change
    create_table :player_stats do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :game_week
      t.jsonb :stats
      t.decimal :fantasy_points

      t.timestamps
    end
  end
end
