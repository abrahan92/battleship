# frozen_string_literal: true

require_relative "../../lib/battleship/player"

module Battleship
  RSpec.describe Player do
    before :each do
      @player = Player.new("Abrahan")
    end

    it "verify player is a valid instance player" do
      expect(@player).to be_an_instance_of(Player)
    end

    it "verify player name is a string" do
      expect(@player.name).to be_a(String)
    end

    it "verify player tries is an integer" do
      expect(@player.tries).to be_a(Integer)
    end
  end
end
