class CreatePerGames < ActiveRecord::Migration
  def change
    create_table :per_games do |t|

      t.string :name
      t.belongs_to :player

      t.timestamps
    end
  end
end
