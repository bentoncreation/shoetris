module Tetris
  class BasePiece
    attr_reader :color, :id
    attr_accessor :left, :top, :bottom, :shape, :rendered

    def initialize(renderer = Proc.new {})
      @id = SecureRandom.uuid
      @left = 0
      @top = 0
      @shape = default_shape
      @renderer = renderer

      @renderer.call(self)
    end

    def right
      left + width
    end

    def bottom
      top + height
    end

    def width
      block_width * block_size
    end

    def block_width
      shape.map { |row| row.rindex(true) || 0 }.max + 1
    end

    def height
      block_height * block_size
    end

    def block_height
      shape.count { |row| row.index(true) }
    end

    def color
      "#000"
    end

    def block_size
      40
    end

    def move_left
      move(-block_size, 0) unless (left - block_size) < 0
    end

    def move_right
      move(block_size, 0) unless (right + block_size) > 400
    end

    def move_up
      rotate_counterclockwise unless (top + width) > 600
    end

    def move_down
      move(0, block_size) unless (bottom + block_size) > 600
    end

    private

    def move(move_left, move_top)
      @left += move_left
      @top += move_top
      @renderer.call(self)
    end

    def rotate_counterclockwise
      @shape = @shape.transpose
      @renderer.call(self)
    end

    def default_shape
      Array[
        [true, true],
        [true, true],
      ]
    end
  end
end
