#bundle exec rake db:populate
#bundle exec rake test:prepare
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make fake teams and teammates 
    teams_by_division = { "Division_1" => ["Twinkies", "Meata", "Smashers", "Jokers", "FlamingRocks", "TidalWave"],
                                      "Division_2" =>  ["Ducks", "Kittens", "Cowboys", "Soldiers", "Falcons", "Olympians"],
                                      "Division_3" => ["Bullets", "Heat", "Storm", "Angelitos"],
                                      "Division_4" => ["Kings", "Enforcers", "Patriots", "Veterans", "Warlocks", "Bulls"],
                                      "Division_5" => ["Quake", "Strikers", "Ballmakers", "dilez", "Argos", "Firestorm"] 
    }

    divisions = ["Division 1", "Division 2", "Division 3", "Division 4", "Division 5"]
    parks = ["Randall's Island", "Red Hook Park", "Hudson River Park", "East River Park"]
    seasons = [{name: "Fall 2012", start_date: DateTime.new(2012, 9, 12, 10, 30), end_date: DateTime.new(2012, 11, 6, 10, 30)},
                    {name: "Spring 2013", start_date: DateTime.new(2013, 5, 8, 9, 30), end_date: DateTime.new(2013, 8, 14, 9, 00)},
                    {name: "Fall 2013", start_date: DateTime.new(2013, 10, 1, 13, 0), end_date: DateTime.new(2013, 11, 4, 12, 30)},
                    {name: "Spring 2014", start_date: DateTime.new(2014, 5, 3, 14, 0), end_date: DateTime.new(2014, 8, 9, 14, 00)}]
    
    generate_default_users
    genDivisions = generate_divisions(divisions, teams_by_division)
    genFields = generate_parks_and_fields(parks) 
    genSeasons = generate_seasons(seasons)
    generate_games( genDivisions, genFields, genSeasons)
    
  end

  def generate_default_users
         # make fake admin
    admin = User.create!(first_name: "Mister", 
                                        last_name: "Admin",  
                                        email: "league+admin@gmail.com", 
                                        permission: 2, 
                                        password: "123456", 
                                        password_confirmation: "123456")
        
    # make fake player
    player = User.create!(first_name: "Misses", 
                                          last_name: "Player",  
                                          email: "league+player@gmail.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")
  end

  # Generate divisions and a Division Rep
  def generate_divisions(divisions, teams_by_division)
    genDivisions = Array.new
    divisions.each do |division|
      divisionObj = Division.create(name:division)
      divisionRep = User.create!(first_name: division, 
                                          last_name: "Representative",  
                                          email: "rep+#{division.gsub!(' ', '_')}@gmail.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")
      genDivisions.push(divisionObj)
      DivisionRep.create(division_id: divisionObj.id, user_id: divisionRep.id)
      generate_teams(teams_by_division, division, divisionObj)
    end 
    return genDivisions  
  end
   # Generate Teams per division, add a manager and a roster of players
  def generate_teams(teams_by_division, division, divisionObj)
      puts division
        teams_by_division[division].each do |team|
          teamObj = Team.create!(name: team)
          # make a different manager for each team
          managerObj = User.create!(first_name: team, 
                                          last_name: "Manager",  
                                          email: "manager+#{team}@gmail.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")
          TeamManager.create!(user_id: managerObj.id, team_id: teamObj.id)
          # Add Team to Division
          TeamDivision.create!(team_id: teamObj.id, division_id: divisionObj.id)
          #populate the team roster
          10.times do |r|
            userObj = User.create!(first_name: Faker::Name.first_name, 
                                          last_name: Faker::Name.last_name, 
                                          email: "testEmail-#{team}#{r}@test.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")

            TeamPlayer.create!(user_id: userObj.id, team_id: teamObj.id)
        end
      end
  end

  # Generates an individual park and an individual field per park
  def generate_parks_and_fields(parks)
    genFields = Array.new
    parks.each do |park|
      parkObj = Park.create!(name: park, 
                        directions_by_car: Faker::Lorem.paragraph,
                        directions_by_transit: Faker::Lorem.paragraph)
      
      fieldObj = Field.create!(name: "#{parkObj.name} Field ##{rand(5..30)}",
                        park_id: parkObj.id)
      genFields.push(fieldObj)

    end
    return genFields
  end

  def generate_seasons(seasons)
    genSeasons = Array.new
    seasons.each do |season|
      seasonObj = Season.create!(name: season[:name],
                            start_date: season[:start_date],
                            end_date: season[:end_date] )
      genSeasons.push(seasonObj)
    end
    return genSeasons
  end

  # for each season generate a few games for every team
  def generate_games(divisions, fields, seasons)
    seasons.each do |season|
      divisions.each do |division|
        teamsD = TeamDivision.where(:division_id => division.id)
        season_start = season.start_date
        game_start = season_start
        teamsD.each do |team_home|
          generate_schedule(teamsD, fields, season, division.id)
        end
      end
    end
  end
  def generate_game(vTeam, hTeam, field, season, division_id, home_score, away_score, game_start)
    game = Game.create!(home_team_id: hTeam.team_id, 
                  visiting_team_id: vTeam.team_id, 
                  field_id: field.id,
                  division_id: division_id,
                  season_id: season.id,
                  start: game_start,
                  home_team_score: home_score,
                  visiting_team_score: away_score
                  )
  end

  def generate_schedule(teams, fields, season, division_id)
      game_start = season.start_date
      startPoint = 0
      endPoint = teams.length - 1
      startTeam = teams[1] 
      currentTeam = "";

      # when you get back to where we started, stop generating schedule (can update this later to add another set of games)
      while !currentTeam.eql?(startTeam);
        startPoint = 0
        # Create a Week of games
        for i in 1..teams.length/2
              field = fields[rand(0..(fields.count-1))]
              home_score = nil
              away_score = nil
              if(game_start < Date.today)
                home_score = rand(0..20)
                away_score = rand(0..20)
              end
              generate_game(teams[endPoint-startPoint], teams[startPoint], field, season, division_id, home_score, away_score, game_start)
              
          startPoint+=1
        end
        game_start = game_start + 7.days - 1.hour

        # shift the array
        lastTeam = teams.pop
        tempTeams = Array.new
        tempTeams[0] = teams[0]
        tempTeams[1] = lastTeam
        for n in 1..teams.length-1
          tempTeams[n+1] = teams[n]
        end
        teams = tempTeams
        currentTeam = teams[1]
      end

    end
end