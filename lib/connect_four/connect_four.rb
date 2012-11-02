class ConnectFour
  attr_reader :game
  def start
    DB.create
    @player1 = Player.new(create_player("Player 1"))
    @player2 = Player.new(create_player("Player 2"))
    @player1.insert_to_db
    @player2.insert_to_db
    @game = Game.new(@player1, @player2)
    play
  end

  def create_player(player)
    puts "Enter username for #{player}"
    player_name = gets.chomp
    puts "Enter your twitter account"
    player_twitter = gets.chomp
    puts "Enter your password"
    player_password = gets.chomp
    return { name: player_name, twitter: player_twitter, password: player_password }
  end

  def play
    until game.board.full? || game.board.check_four_consecutive?
      game.next_round == "black" ? current_turn = "#{player1.name}" : current_turn = "#{player2.name}"
      if current_turn == "Computer"
        game.next_move(rand(7))
      else
        puts "#{current_turn}, what column do you want to play in?"
        game.next_move(gets.chomp)
      end
    end
    puts "The game is over."
  end

end
