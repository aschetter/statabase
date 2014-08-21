## STATaBase

Description: A Rails-based API used to measure the value of NBA players by comparing their statistics against their salaries. The information is scraped from the web, and compiled into a database for HTTP requests.

If a player plays on more than one team in a given season, the online database only showed the player's whole salary on one team and none on the other(s). To best calculate a player's value, the data was normalized to show a player's relative salary earned playing on a given team. This was adjusted by totaling the percentage of season games a player played for a given team and multiplying it by his total salary.

Live Site: http://statabase.herokuapp.com

Tech Stack: This application utilizes Rails, Ruby, and Nokogiri Gem.

### Documentation

#### Statistics Available:

##### 1. Stats:
  - Standard stat line totals for a single player.

##### 2. Advanced Stats:
  - Advanced stat line totals for a single player.

##### 3. Salaries:
  - The amount of money a player earned on a given team.

##### 4. Win Shares:
  - The estimated amount of wins a player contributed to a team.

##### 5. Win Shares Index:
  - Compares a player's win share contribution in relation to his salary.
  - Normalized so that the MVP's win share index is roughly equal to 1.

##### 6. Cost Per Point:
  - Compares a player's total points scored in relation to his salary.

##### 7. Cost Per Assist:
  - Compares a player's total assists in relation to his salary.

##### 8. Cost Per Rebound:
  - Compares a player's total rebounds in relation to his salary.

##### 9. Cost Per Block:
  - Compares a player's total blocks in relation to his salary.

##### 10. Cost Per Minute:
  - Compares a player's total minutes in relation to his salary.

### HTTP Requests:

#### All requests must start with the api base url: http://statabase.herokuapp.com.
##### Additional parameters can be added by the following routes.

#### SEASONS

      Season id can be passed as the database season id or the year.
      For example: 2014.

      GET /seasons
        Get all seasons

      GET /seasons/:id
        Get a single season

      GET /seasons/:id/stats
        Get all player stats for a single season

      GET /seasons/:id/advanced_stats
        Get all player advanced stats for a single season

      GET /seasons/:id/salaries
        Get all player salaries for a single season

      GET /seasons/:id/win_shares
        Get all player win shares for a single season

      GET /seasons/:id/win_shares_index
        Get all player win shares indices for a single season

      GET /seasons/:id/cost_per_point
        Get all player cost per point scored totals for a single season

      GET /seasons/:id/cost_per_assist
        Get all player cost per assist totals for a single season

      GET /seasons/:id/cost_per_rebound
        Get all player cost per rebound totals for a single season

      GET /seasons/:id/cost_per_block
        Get all player cost per block totals for a single season

      GET /seasons/:id/cost_per_minute
        Get all player cost per minute totals for a single season

#### TEAMS

      Team id can be passed as the database id or as the three-letter team identifiers:

| Identifier | Team | Identifier | Team | Identifier | Team |
| ---------- | ---- | ---------- | ---- | ---------- | ---- |
| ATL | Atlanta | HOU | Houston | OKC | Oklahoma City |         
| BOS | Boston | IND | Indiana | ORL | Orlando |               
| BRK | Brooklyn | LAC | LA Clippers | PHI | Philadelphia |                
| CHA | Charlotte | LAL | LAL Lakers | PHO | Phoenix |             
| CHI | Chicago | MEM | Memphis | POR | Portland |                   
| CLE | Cleveland | MIA | Miami | SAC | Sacramento |               
| DAL | Dallas | MIL | Milwaukee | SAS | San Antonio |                 
| DEN | Denver | MIN | Minnesota | TOR | Toronto |                
| DET | Detroit | NOP | New Orleans | UTA | Utah |                  
| GSW | Golden State | NYK | New York | WAS | Washington |              

      GET /seasons/:season_id/teams
        Get all teams in a given season

      GET /seasons/:season_id/teams/:id
        Get a single team in a given season

      GET /seasons/:season_id/teams/:id/stats
        Get all player stats for a given team in a single season

      GET /seasons/:season_id/teams/:id/advanced_stats
        Get all player advanced stats for a given team in a single season

      GET /seasons/:season_id/teams/:id/salaries
        Get all player salaries for a given team in a single season

      GET /seasons/:season_id/teams/:id/win_shares
        Get all player win shares for a given team in a single season

      GET /seasons/:season_id/teams/:id/win_shares_index
        Get all player win shares indices for a given team in a single season

      GET /seasons/:season_id/teams/:id/cost_per_point
        Get all player cost per point scored totals for a given team in a single season

      GET /seasons/:season_id/teams/:id/cost_per_assist
        Get all player cost per assist totals for a given team in a single season

      GET /seasons/:season_id/teams/:id/cost_per_rebound
        Get all player cost per rebound totals for a given team in a single season

      GET /seasons/:season_id/teams/:id/cost_per_block
        Get all player cost per block totals for a given team in a single season

      GET /seasons/:season_id/teams/:id/cost_per_minute
        Get all player cost per minute totals for a given team in a single season

#### PLAYERS

      Player id can be passed as the database id or as the player name with the
      proper capitalization and spacing. For example:

          lebronjames  -- incorrect
          Lebron James -- incorrect
          LeBron James -- correct

      GET /seasons/:season_id/teams/:team_id/players
        Get all players for a given team in a single season

      GET /seasons/:season_id/teams/:team_id/players/:id
        Get a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/stats
        Get stats for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/advanced_stats
        Get advanced stats for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/salaries
        Get salary for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/win_shares
        Get win shares for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/win_shares_index
        Get win shares index for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/cost_per_point
        Get cost per point total for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/cost_per_assist
        Get cost per assist total for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/cost_per_rebound
        Get cost per rebound total for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/cost_per_block
        Get cost per block total for a single player for a single team in a given season

      GET /seasons/:season_id/teams/:team_id/players/:id/cost_per_minute
        Get cost per minute total for a single player for a single team in a given season
