class CreateSeasonTeams < ActiveRecord::Migration
  def change
    create_table :season_teams do |t|

      t.belongs_to :team
      t.belongs_to :season

      t.timestamps
    end
  end
end
