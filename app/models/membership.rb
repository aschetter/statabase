class Membership < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :season
  has_one :stat
  has_one :adv
end
