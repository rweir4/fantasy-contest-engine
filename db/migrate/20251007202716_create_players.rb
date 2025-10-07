class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.decimal :salary
      t.string :team

      t.timestamps
    end
  end
end
