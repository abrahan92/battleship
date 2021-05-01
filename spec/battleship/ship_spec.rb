# frozen_string_literal: true

require_relative "../../lib/battleship/ship"
require_relative "../../lib/battleship/cell"

module Battleship
  RSpec.describe Ship do
    before :each do
      @ship = Ship.new(3)
    end

    it "verify ship is a valid instance ship" do
      expect(@ship).to be_an_instance_of(Ship)
    end

    it "verify ship size is an integer" do
      expect(@ship.size).to be_a(Integer)
    end

    it "verify ship name is correct" do
      expect(@ship.name).not_to be_nil
    end

    context "Verify methods for ship" do
      it "check set_cells method return a cells array" do
        cells = Array.new
        cells.push(Cell.new(0, 0), Cell.new(0, 1), Cell.new(0, 2))

        expect(@ship.set_cells(cells)).to all(be_an(Cell))
      end

      it "check hint method return a cells occupied" do
        cell = Cell.new(0, 0)
        cell.occupied!
        @ship.cells.push(cell)

        expect(@ship.hint).to have_attributes(status: :occupied)
      end
    end
  end
end
