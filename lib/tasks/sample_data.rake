namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    5.times do |n|
      team = Team.create!(name: Faker::Lorem.words(1))
      10.times do |n|
        fakeName = Faker::Name.name,
        player = Player.create!(name: fakeName,  email: "testEmail#{n}@test.com", password: "123456", password_confirmation: "123456")
        TeamPlayer.create!(player_id: player.id, team_id: team.id)
      end
    end
    
  end
end