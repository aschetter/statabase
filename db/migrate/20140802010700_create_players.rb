class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|

      t.string  :br_id
      t.string  :name
      t.integer :number
      t.string  :position
      
      t.string  :height
      t.string  :weight
      t.string  :birth_date
      t.string  :experience
      t.string  :college

      t.timestamps
    end
  end
end
