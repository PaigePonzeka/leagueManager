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
    
    #make fake manager for each team
    divisions.each do |division|
      divisionObj = Division.create(name:division)
      divisionRep = User.create!(first_name: division, 
                                          last_name: "Representative",  
                                          email: "rep+#{division}@gmail.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")
      #create Division Rep
      DivisionRep.create(division_id: divisionObj.id, user_id: divisionRep.id)
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
  end
end