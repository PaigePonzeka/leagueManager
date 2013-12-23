teams = ["team1", "team2", "team3", "team4", "team5", "team6"]
games = Array.new

startPoint = 0
endPoint = teams.length - 1
startTeam = teams[1] 
currentTeam = "";

while !currentTeam.eql?(startTeam);
  puts "here"
  week = Array.new
  startPoint = 0
  for i in 1..teams.length/2
    game = "#{teams[startPoint]} vs. #{teams[endPoint-startPoint]}"
    week.push(game)
    startPoint+=1
  end
  games.push(week)
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

puts games.inspect
