class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|

      t.string  :br_id

      t.string  :name
      t.integer :salary
      t.integer :number
      t.string  :name
      t.string  :position
      
      t.string  :height
      t.string  :weight
      t.string  :birth_date
      t.string  :experience
      t.string  :college







      t.belongs_to :team

      t.timestamps
    end
  end
end
