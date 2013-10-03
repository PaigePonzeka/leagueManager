#bundle exec rake db:populate
#bundle exec rake test:prepare
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make fake teams and teammates 
    teams_by_division = { "Sachs" => ["Grizzlies", "A-Team", "Bashers", "Jesters", "Comets"],
                                      "Dima" =>  ["Wings", "Mavericks", "Bandits", "Warriors", "Eagle", "Titans"],
                                      "Stonewall" => ["Arsenal", "Fusion", "Cyclones", "Diabiltos"],
                                      "Fitzpatrick" => ["Empires", "Renegades", "Rebels", "Rookies", "Demons", "Rams"],
                                      "Rainbow" => ["Noreasters", "Swingers", "Ballbreakers", "gatorz", "Sirens", "Spitfire", "Hotshots"] 
    }

    divisions = ["Sachs", "Dima", "Stonewall", "Fitzpatrick", "Rainbow"]
    parks = ["Randall's Island", "Red Hook Park", "Hudson River Park", "East River Park"]
    seasons = [{name: "Fall 2012", start_date: Date.new(2012, 9, 12), end_date: Date.new(2012, 11, 6)},
                    {name: "Spring 2013", start_date: Date.new(2013, 5, 8), end_date: Date.new(2013, 8, 14)},
                    {name: "Fall 2013", start_date: Date.new(2013, 9, 3), end_date: Date.new(2013, 11, 4)},
                    {name: "Spring 2014", start_date: Date.new(2014, 5, 3), end_date: Date.new(2014, 8, 9)}]
    
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
                                        email: "paigepon+admin@gmail.com", 
                                        permission: 2, 
                                        password: "123456", 
                                        password_confirmation: "123456")
        
    # make fake player
    player = User.create!(first_name: "Misses", 
                                          last_name: "Player",  
                                          email: "paigepon+player@gmail.com", 
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
                                          email: "rep+#{division}@gmail.com", 
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
        teams_by_division[division].each do |team|
          teamObj = Team.create!(name: team)
          # make a different manager for each team
          managerObj = User.create!(first_name: team, 
                                          last_name: "Manager",  
                                          email: "paigepon+#{team}@gmail.com", 
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
        teamsD.each do |team_home|
          teamsD.each do |team_away|
            field = fields[rand(0..(fields.count-1))]
            game = Game.create!(home_team_id: team_home.team_id, 
                                            visiting_team_id: team_away.team_id, 
                                            field_id: field.id,
                                            division_id: division.id,
                                            season_id: season.id

                                            )
          end
        end
      end
    end
  end
end