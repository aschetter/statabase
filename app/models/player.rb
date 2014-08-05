class Player < ActiveRecord::Base
  # has_many :memberships
  # has_many :teams, :through => :memberships

  has_one :adv
  has_one :stat
  belongs_to :team
end
