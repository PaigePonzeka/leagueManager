#bundle exec rake db:populate
#bundle exec rake test:prepare
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make fake teams and teammates 
    5.times do |n|
      team = Team.create!(name: Faker::Lorem.words(1))
      
      10.times do |r|
        fakeName = Faker::Name.name
        user = User.create!(name: fakeName,  email: "testEmail-#{n}#{r}@test.com", password: "123456", password_confirmation: "123456")
        TeamPlayer.create!(user_id: user.id, team_id: team.id)
      end
    end
    # make fake admin
    admin = User.create!(name: "Paige Ponzeka",  email: "paigepon+admin@gmail.com", permission: 2, password: "123456", password_confirmation: "123456")
        
    # make fake player
    admin = User.create!(name: "Paige Ponzeka",  email: "paigepon+player@gmail.com", password: "123456", password_confirmation: "123456")
      
  end
end