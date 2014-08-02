class Season < ActiveRecord::Base
  has_many :season_teams
  has_many :teams, :through => :season_teams

  has_many :teams
  has_many :players, :through => :teams
end
