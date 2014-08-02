class Player < ActiveRecord::Base
  has_many :memberships
  has_many :teams, :through => :memberships

  has_many :teams
  has_many :seasons, :through => :teams
end
