# frozen_string_literal: true

module Battleship
  class Ship
    attr_reader :name, :size, :cells

    def initialize(size, status = :alive)
      @size = size
      @name = set_name
      @cells = Array.new
      @status = status
    end

    def set_cells(cells)
      @cells = cells
    end

    def alive?
      @status == :alive
    end

    def sunk?
      @status == :sunk
    end

    def sunk!
      @status = :sunk
    end

    def check_sunk
      if cells.all?(&:hitted?)
        @status = :sunk
      end
    end

    def hint
      cells.select(&:occupied?).sample
    end

    private

    def set_name
      case @size
      when 2 then "Patrol boat"
      when 3 then "Destroyer"
      when 4 then "Battleship"
      when 5 then "Aircraft"
      end
    end
  end
end
