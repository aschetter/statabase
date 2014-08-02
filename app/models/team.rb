class Team < ActiveRecord::Base
  has_many :memberships
  has_many :players, :through => :memberships

  has_many :season_teams
  has_many :seasons, :through => :season_teams

  belongs_to :player
  belongs_to :season
end
