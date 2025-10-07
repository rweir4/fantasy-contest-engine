class CreateLineupPlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :lineup_players do |t|
      t.references :lineup, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :position_slot

      t.timestamps
    end
  end
end
