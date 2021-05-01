# frozen_string_literal: true

require "colorize"
require_relative "player"
require_relative "board"

module Battleship
  class Game
    attr_reader :size, :boards, :player_turn, :board_turn, :board_player1, :board_player2

    def initialize(size, random, best_of3)
      @best_of3 = best_of3
      setup(size, random, best_of3)
    end

    # Setup game and play
    def play
      board_setup
      gameplay_setup
    end

    # Constructor with validations if mode = best_of3 then
    # players play 3 matches in a row if not just play 1 match
    # and cli will ask user if want to play another match
    def setup(size, random, best_of3)
      @size = size

      if best_of3 && @board_player1 && @board_player2
        @board_player1 = Board.new(size, @board_player1.player)
        @board_player2 = Board.new(size, @board_player2.player)
      else
        @board_player1 = Board.new(size, Player.new("abrahan"))
        @board_player2 = Board.new(size, Player.new("bot"))
      end

      @boards = [@board_player1, @board_player2]
      @players = @boards.map(&:player)
      @random = random
      @board_turn = random ? @boards.sample : @boards.first
    end

    # Setup all boards with ships for all users
    def board_setup
      puts ""
      puts "**********************".green
      puts "1st step - Board setup".green
      puts "**********************".green
      puts ""

      player1_title = @best_of3 ? "#{@board_player1.player.wins} wins" : ""
      puts "Player #{@board_player1.player.name} #{player1_title}".blue
      @board_player1.set_board

      player2_title = @best_of3 ? "#{@board_player2.player.wins} wins" : ""
      puts "Player #{@board_player2.player.name} #{player2_title}".blue
      @board_player2.set_board
    end

    # User set shoot in his turn, if that shoot
    # make user wins and best_of3 mode players they will play
    # another match until someone wins at least 2
    def gameplay_setup
      game_status = :new_game

      loop do
        print_player_turn(@board_turn.player.name)

        print "Introduce your shoot - x, y: ".blue
        shoot = $stdin.gets.chomp.split(",").map(&:to_i)
        game_shoot = set_shoot(shoot)

        case game_shoot
        when :finished, :finished_game_of3
          break
        when :new_game
          game_status = :play_again
          break
        end
      end

      if game_status == :play_again
        setup(5, true, @best_of3)
        play
      end
    end

    # Print header for a new game
    def print_header
      print "\e[H\e[2J"
      puts "*************************".green
      puts "2nd step - Gameplay setup".green
      puts "*************************".green
    end

    # Print header for the player turn
    def print_player_turn(name)
      sleep 1
      print_header
      puts ""
      puts "#{name} turn #{@best_of3 ? "#{@board_turn.player.wins} wins" : ''}".cyan
      puts "*************************".cyan
      puts ""
    end

    # Give the turn to the opposing player
    def next_turn
      @player_turn = @players.reject { |player| player.id == @board_turn.player.id }.first
      @board_turn = @boards.select { |board| board.player.id == @player_turn.id }.first
    end

    # Ask if players want to play a new match
    def ask_new_game
      print "Would you like to start a new game?: [y/n]".blue
      new_game = $stdin.gets.chomp

      if new_game.downcase == "y"
        print "\e[H\e[2J"
        :new_game
      else
        puts "Bye!!!".green
        :finished
      end
    end

    # Check if some player win the match or best_of3 rounds
    def verify_winner(opponent_board)
      if opponent_board.ships.all?(&:sunk?)
        @board_turn.player.set_win

        if @best_of3 && @boards.map(&:player).any? { |player| player.wins > 1 }
          puts "*******************************************************".green
          puts "Player #{@board_turn.player.name} has won best of 3!!!!".green
          puts "********************************************************".green
        elsif @best_of3 && @boards.map(&:player).any? { |player| player.wins <= 1 }
          puts "*********************************************".green
          puts "Player #{@board_turn.player.name} has won a game of 3!!!!".green
          puts "*********************************************".green
        else
          puts "*********************************************".green
          puts "Player #{@board_turn.player.name} has won a single game!!!!".green
          puts "*********************************************".green
        end

        if @random && @best_of3 && @boards.map(&:player).all? { |player| player.wins < 2 }
          print "#{@board_turn.player.name} wins, enter for next match?: ".cyan
          $stdin.gets.chomp

          print "\e[H\e[2J"
          :new_game
        elsif @random && @boards.map(&:player).any? { |player| player.wins > 1 }
          :finished_game_of3
        elsif @random
          ask_new_game
        else
          :finished
        end
      else
        next_turn
        :hitted
      end
    end

    # Hit the opponent ship on the cell request by current player
    # and if ship has all cells hitted it will be sunk
    def hit_ship(opponent_board, opponent_cell)
      opponent_cell.hitted!
      opponent_ship = opponent_board.get_ship_by_cell(opponent_cell)
      opponent_ship.check_sunk
      puts "Ship #{opponent_ship.name} has been sunked".yellow if opponent_ship.sunk? && @random
    end

    # Show hint cell if player miss 3 hits in a row
    def show_hint(hint)
      print "Hint for you, try with (#{hint.coord_x}, #{hint.coord_y}), [Enter to continue]".cyan
      $stdin.gets.chomp
    end

    # Check the shot made by the user, if was a [hit, miss, out or blocked] shot
    def set_shoot(shoot)
      opponent_board = @boards.reject { |board| board.player.id == @board_turn.player.id }.first
      opponent_cell = opponent_board.find_cell(shoot)

      if opponent_cell.nil?
        puts "Cell not available, try again".yellow
        :empty
      elsif opponent_cell.occupied?
        puts "Hitted!!!!".yellow if @random
        @board_turn.player.reset_tries
        hit_ship(opponent_board, opponent_cell)
        verify_winner(opponent_board)
      elsif opponent_cell && opponent_cell.empty?
        puts "Missed!!!!".yellow if @random
        opponent_cell.missed!
        @board_turn.player.missed_shoot
        if @board_turn.player.tries == 3
          hint = opponent_board.ships.sample.hint
          show_hint(hint)
        end
        next_turn
        :missed
      else
        puts "hit not permitted, try again".yellow if @random
        :not_permitted
      end
    end
  end
end
