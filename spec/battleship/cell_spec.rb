# frozen_string_literal: true

require_relative "../../lib/battleship/cell"

module Battleship
  RSpec.describe Cell do
    before :each do
      @valid_status = %i[empty occupied hitted sunken missed blocked]
      @cell = Cell.new(1, 2)
    end

    it "verify cell is a valid instance cell" do
      expect(@cell).to be_an_instance_of(Cell)
    end

    it "verify x, y coordinates are integers" do
      expect(@cell.coord_x).to be_a(Integer)
      expect(@cell.coord_y).to be_a(Integer)
    end

    it "verify cell status is valid" do
      expect(@valid_status).to include(@cell.status)
    end
  end
end
