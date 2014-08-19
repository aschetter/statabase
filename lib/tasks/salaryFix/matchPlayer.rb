module BBall
  
  def self.matchPlayer(memberships)

    @players_memberships = []

    memberships.each do |memberships|
      membership = Membership.where(season_id: memberships.season_id, player_id: memberships.player_id)
      @players_memberships << membership
    end

    @players_memberships
  end
end
