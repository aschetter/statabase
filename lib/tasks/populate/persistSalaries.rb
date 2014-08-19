module BBall
  
  def self.persistSalaries(attrs, player_salaries)

    @salary_list = {
      added: [],
      updated: []
    }
    
    player_salaries.each do |player|
      @db_player = Player.find_by(br_id: player[:br_id])

      if @db_player.nil?
        @db_player = Player.create(
          br_id: player[:br_id],
          name: player[:name]
        )

        Membership.create(player_id: @db_player.id, team_id: attrs[:@db_team][:id], season_id: attrs[:@db_season][:id], salary: player[:salary])

        $team_stats[:salaries][:added] += 1
        @salary_list[:added] << @db_player.name
        
      else
        membership = Membership.find_by(season_id: attrs[:@db_season][:id], team_id: attrs[:@db_team][:id], player_id: @db_player[:id])
        membership.salary = player[:salary]
        membership.save

        $team_stats[:salaries][:updated] += 1
        @salary_list[:updated] << @db_player.name
      end
    end

    puts ""    
    puts "PLAYERS ADDED WITH JUST SALARY:"
    @salary_list[:added].each do |player|
      puts player
    end

    puts ""    
    puts "ADDED SALARY TO:"
    @salary_list[:updated].each do |player|
      puts player
    end
  end
end
