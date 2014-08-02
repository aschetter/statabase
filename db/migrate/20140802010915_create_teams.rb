class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|

      t.string :br_id

      t.timestamps
    end
  end
end
