# frozen_string_literal: true

module Battleship
  class Player
    attr_reader :name, :id, :tries, :wins

    def initialize(name = "")
      @name = name
      @id = rand(1..10_000)
      @tries = 0
      @wins = 0
    end

    def set_win
      @wins += 1
    end

    def missed_shoot
      @tries += 1
    end

    def reset_tries
      @tries = 0
    end
  end
end
