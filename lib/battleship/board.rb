# frozen_string_literal: true

require "colorize"
require_relative "cell"

module Battleship
  class Board
    attr_reader :size, :player, :storage, :ships

    def initialize(size, player)
      @size = size
      @player = player
      @storage = (0...@size).to_a.product((0...@size).to_a).map do |coord_x, coord_y|
        Cell.new(coord_x, coord_y)
      end
      @ships = Array.new
    end

    # Create all ships for the playing board
    def set_board
      # Create first ship
      set_ship(Ship.new(3))

      # Create second ship
      set_ship(Ship.new(4))
    end

    # Ask player for a valid coordinate and then check if that coordinate
    # is valid for create a ship
    def set_ship(ship)
      loop do
        print "Introduce the initial coordinate of your #{ship.name} ship - x, y: ".blue
        coordinate = $stdin.gets.chomp.split(",").map(&:to_i)
        break if valid_coord?(find_cell(coordinate), ship)
      end
    end

    def get_ship_by_cell(cell)
      ships.select do |ship|
        ship.cells.select do |map_cell|
          map_cell.coord_x == cell.coord_x && map_cell.coord_y == cell.coord_y
        end.first
      end.first
    end

    # Find a cell by coordinate on the board
    def find_cell(coordinate)
      storage.select do |cell|
        cell.coord_x == coordinate[0] && cell.coord_y == coordinate[1]
      end.first
    end

    # Verify is prompted coordinate by user is valid and available to create the ship
    def valid_coord?(cell, ship)
      if cell && cell.empty?
        find_cells = build_ship_with_index_cell(ship.size, cell)
        if find_cells&.all? do |look_cell|
             !look_cell.nil?
           end && find_cells.select(&:empty?).count == find_cells.count
          set_ship_cells(ship, find_cells)
          true
        else
          puts "Ship cannot be placed at this coordinate, try again".yellow
          false
        end
      else
        puts "Cell not available, try again".yellow
        false
      end
    end

    # Build a ship with an index cell using ship size
    def build_ship_with_index_cell(ship_size, index_cell)
      cells = Array.new
      ship_size.times do |index|
        find_cell = storage.select do |cell|
          cell.coord_x == index_cell.coord_x && (cell.coord_y == index_cell.coord_y + index)
        end.first
        cells.push(find_cell)
      end
      cells
    end

    # Get all possible neighbors of a cell
    def get_neighbors_from_cell(cell)
      coordinates = [
        [cell.coord_x + 1, cell.coord_y],
        [cell.coord_x - 1, cell.coord_y],
        [cell.coord_x, cell.coord_y - 1],
        [cell.coord_x, cell.coord_y + 1],
        [cell.coord_x - 1, cell.coord_y + 1],
        [cell.coord_x + 1, cell.coord_y + 1],
        [cell.coord_x - 1, cell.coord_y - 1],
        [cell.coord_x + 1, cell.coord_y - 1]
      ]

      neighbors = coordinates.map do |coordinate|
        find_cell(coordinate)
      end

      neighbors.select { |neighbor| neighbor && neighbor.empty? }
    end

    # Set cells used by placed ship then add the ship to the board
    def set_ship_cells(ship, cells)
      cells.each do |cell|
        cell.occupied!
        neighbors = get_neighbors_from_cell(cell)
        neighbors.each(&:blocked!)
      end
      ship.set_cells(cells)

      ships.push(ship)
    end

    # Get the number of board's cells
    def number_of_cells(size)
      size * size
    end
  end
end
