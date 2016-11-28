require "securerandom"

module Tetris
  class BasePiece
    attr_reader :color, :id
    attr_accessor :left, :top, :left_px, :top_px, :bottom, :shape, :rendered

    def initialize(map, renderer = Proc.new {})
      @id = SecureRandom.uuid
      @left = 0
      @top = 0
      @shape = default_shape
      @map = map
      @renderer = renderer

      @renderer.call(self)
    end

    def at_left_edge?
    end

    def at_right_edge?
    end

    def blocked_down?
      false
    end

    # def right
    #   left + width
    # end

    # def bottom
    #   top + height
    # end

    # def width
    #   block_width * block_size
    # end

    # def block_width
    #   shape.map { |row| row.rindex(true) || 0 }.max + 1
    # end

    # def height
    #   block_height * block_size
    # end

    # def block_height
    #   shape.count { |row| row.index(true) }
    # end

    def left_px
      left * 40
    end

    def top_px
      top * 40
    end

    def block_attributes(x, y)
      [
        left_px + x * unit_size,
        top_px + y * unit_size,
        unit_size,
        unit_size
      ]
    end

    def color
      "#000"
    end

    def unit_size
      40
    end

    def move_left
      @left -= 1 #unless (left - block_size) < 0
      update_map
    end

    def move_right
      @left += 1 #unless (right + block_size) > 400
      update_map
    end

    def move_up
      @shape = @shape.transpose #unless (top + width) > 600
      update_map
    end

    def move_down
      @top += 1 #unless (bottom + block_size) > 600
      update_map
    end

    def update_map
      @map.update_piece(self)
      @renderer.call(self)
    end

    private

    def default_shape
      Array[
        [true, true],
        [true, true],
      ]
    end
  end
end
