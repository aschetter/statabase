class SeasonTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :season
end
