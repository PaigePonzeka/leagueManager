#bundle exec rake db:populate
#bundle exec rake test:prepare
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make fake teams and teammates 
    teams = ["Grizzlies", "A-Team", "Bashers", "Jesters", "Comets"]
    5.times do |n|
      team = Team.create!(name: teams[n])
      
      10.times do |r|
        user = User.create!(first_name: Faker::Name.first_name, 
                                          last_name: Faker::Name.last_name, 
                                          email: "testEmail-#{n}#{r}@test.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")

        TeamPlayer.create!(user_id: user.id, team_id: team.id)
      end
    end
    # make fake admin
    admin = User.create!(first_name: "Mister", 
                                        last_name: "Admin",  
                                        email: "paigepon+admin@gmail.com", 
                                        permission: 2, 
                                        password: "123456", 
                                        password_confirmation: "123456")
        
    # make fake player
    admin = User.create!(first_name: "Misses", 
                                          last_name: "Player",  
                                          email: "paigepon+player@gmail.com", 
                                          password: "123456", 
                                          password_confirmation: "123456")
    
    #make fake manager
    admin = User.create!(first_name: "Mr.", 
                                          last_name: "Manager",  
                                          email: "paigepon+manager@gmail.com", 
                                          permission: 1, 
                                          password: "123456", 
                                          password_confirmation: "123456")
      
  end
end