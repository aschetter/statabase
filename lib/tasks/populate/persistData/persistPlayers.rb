module BBall
  
  def self.persistPlayers(attrs, player_bios)

    @team_players = {
      added: [],
      in_db: []
    }

    player_bios.each do |player|

      @db_player = Player.find_by(br_id: player[:br_id])

      if @db_player.nil?

        @db_player = Player.create(
          br_id: player[:br_id],
          name: player[:name],
          number: player[:number],
          position: player[:position],

          height: player[:height],
          weight: player[:weight],
          birth_date: player[:birth_date],
          experience: player[:experience],
          college: player[:college]
        )

        attrs[:players][:added] += 1
        @team_players[:added] << @db_player

      else

        attrs[:players][:already_in_db] += 1
        @team_players[:in_db] << @db_player
      end
    end

    puts ""
    puts "ADDED THE FOLLOWING PLAYERS TO THE DB:"

    @team_players[:added].each do |player|
      puts player.name
    end

    puts ""
    puts "THESE PLAYERS WERE ALREADY IN THE DB:"

    @team_players[:in_db].each do |player|
      puts player.name
    end

    @team_players
  end
end
