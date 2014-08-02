class Season < ActiveRecord::Base
  has_many :season_teams
  has_many :teams, :through => :season_teams
end
