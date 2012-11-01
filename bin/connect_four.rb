#!/usr/bin/ruby
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'


player1 = Player.new(1)
player2 = Randall.new(2)
game = Game.new(player1, player2)
puts "WELCOME TO GAME"

until game.over?
	puts "#{game.current_player} take turn"
	successful = game.take_turn
  puts "try again" unless successful
end
puts game.winner