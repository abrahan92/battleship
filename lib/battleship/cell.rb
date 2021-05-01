# frozen_string_literal: true

module Battleship
  class Cell
    attr_reader :status, :coord_x, :coord_y

    def initialize(coord_x, coord_y, status = :empty)
      @status = status
      @coord_x = coord_x
      @coord_y = coord_y
    end

    def empty?
      @status == :empty
    end

    def occupied?
      @status == :occupied
    end

    def occupied!
      @status = :occupied
    end

    def hitted?
      @status == :hitted
    end

    def hitted!
      @status = :hitted
    end

    def sunken?
      @status == :sunken
    end

    def sunken!
      @status = :sunken
    end

    def missed?
      @status == :missed
    end

    def missed!
      @status = :missed
    end

    def blocked?
      @status == :blocked
    end

    def blocked!
      @status = :blocked
    end
  end
end
