def persistSeason(year)
  @db_season = Season.find_by(year: year)

  if @db_season.nil?
    @db_season = Season.create(year: year)
    puts ""
    puts "ADDED TO THE DATABASE: #{@db_season.year}"
  else
    puts ""
    puts "#{@db_season.year} IS ALREADY IN THE DATABASE."
  end

  @db_season
end
