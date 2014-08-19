module BBall
  
  def self.persistTeam(br_id)
    
    teams = %w[ ATL BOS BRK CHA CHI CLE DAL DEN DET GSW 
                HOU IND LAC LAL MEM MIA MIL MIN NOP NYK
                OKC ORL PHI PHO POR SAC SAS TOR UTA WAS ]

    @db_team = Team.find_by(br_id: teams[br_id])

    if @db_team.nil?
      @db_team = Team.create(br_id: teams[br_id])
      puts ""
      puts "ADDED TO THE DATABASE: #{@db_team.br_id}"
    else
      puts ""
      puts "#{@db_team.br_id} IS ALREADY IN THE DATABASE."
    end

    @db_team
  end
end
