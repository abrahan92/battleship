# frozen_string_literal: true

require_relative "../../lib/battleship/game"
require_relative "../../lib/battleship/ship"

module Battleship
  RSpec.describe Game do
    before :each do
      @game = Game.new(5, false, false)
    end

    it "verify game is a valid instance game" do
      expect(@game).to be_an_instance_of(Game)
    end

    it "verify size is integer" do
      expect(@game.size).to be_a(Integer)
    end

    it "verify game has an array of boards " do
      expect(@game.boards).to include(a_kind_of(Board))
    end

    it "verify game has 2 boards" do
      expect(@game.boards.count).to eq(2)
    end

    context "Verify methods for game" do
      before :each do
        @game.board_player2.valid_coord?(Cell.new(2, 1), Ship.new(3))
        @game.board_player2.valid_coord?(Cell.new(4, 0), Ship.new(4))
      end

      context "check set_shoot method for game" do
        it "check is shoot missed" do
          expect(@game.set_shoot([0, 0])).to eq(:missed)
        end

        it "check is shoot hitted" do
          expect(@game.set_shoot([2, 1])).to eq(:hitted)
        end

        it "check is shoot is not permitted" do
          expect(@game.set_shoot([1, 0])).to eq(:not_permitted)
        end
      end
    end
  end
end
