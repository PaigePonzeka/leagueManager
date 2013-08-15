namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    5.times do |n|
      team = Team.create!(name: Faker::Lorem.words(1))
      10.times do |n|
        player = Player.create!(name: Faker::Name.name)
        TeamPlayer.create!(player_id: player.id, team_id: team.id)
      end
    end
    
  end
end