module Tetris
  class Rectangle
    attr_reader :left, :top, :width, :height

    def initialize(left, top, width, height)
      @left = left
      @top = top
      @width = width
      @height = height
    end
  end
end
