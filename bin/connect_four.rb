#!/usr/bin/ruby
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'

def new_game
  players = [Player.new("Human", 1), AIPlayer5.new("kunal", 2)].shuffle!
  game = Game.new(players[0], players[1])

  puts "WELCOME TO GAME"
  until game.over?
    puts "#{game}"
    puts "#{game.current_player} take turn"

    successful = game.take_turn
    return false if successful == :quit

    puts "try again" unless successful
  end

  puts "Winning Player: #{game.winner}"
  puts "#{game}"

  if game.winner.nil?
    return "tie"
  else
    game.winner.name
  end

end



winners = []
loop do
  winner = new_game
  break unless winner
  winners << winner
end
p winners
