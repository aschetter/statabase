class Player < ActiveRecord::Base
  has_many :memberships
  has_many :teams, :through => :memberships

  has_many :per_games
  has_many :stats
end
