# frozen_string_literal: true

require_relative "../../lib/battleship/player"
require_relative "../../lib/battleship/board"

module Battleship
  RSpec.describe Board do
    before :each do
      @board = Board.new(5, Battleship::Player.new("Abrahan"))
    end

    it "verify board is a valid instance board" do
      expect(@board).to be_an_instance_of(Board)
    end

    it "finds cell on board by coordinate" do
      cell = @board.find_cell([1, 1])
      expect(cell).to be_an_instance_of(Cell)
    end

    it "verify board number_of_cells method return a valid integer" do
      expect(@board.number_of_cells(@board.size)).to be_a(Integer)
    end

    it "verify size of board by size" do
      expect(@board.storage.count).to eq(@board.number_of_cells(@board.size))
    end

    context "Verify methods for board using a cell" do
      let(:cell) { Cell.new(1, 1) }

      it "check get_neighbors_from_cell method return a cells array" do
        expect(@board.get_neighbors_from_cell(cell)).to all(be_an(Cell))
      end

      it "check build_ship_with_index_cell method return a cells array" do
        expect(@board.build_ship_with_index_cell(3, cell)).to all(be_an(Cell))
      end
    end
  end
end
