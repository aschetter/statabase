def matchPlayer(memberships)

  @players_memberships = []

  memberships.each do |memberships|
    @players_memberships << Membership.where(season_id: memberships.season_id, player_id: memberships.player_id)
  end

  @players_memberships
end
