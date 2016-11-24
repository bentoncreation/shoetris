class Iblock
  attr_reader :color
  attr_accessor :left, :top, :shape

  def initialize(renderer = Proc.new {})
    @left = 0
    @top = 0
    @shape = default_shape
    @renderer = renderer

    @renderer.call(self)
  end

  def color
    "#0ff"
  end

  def block_size
    40
  end

  def move_left
    move(-block_size, 0) unless (left - block_size) < 0
  end

  def move_right
    move(block_size, 0) unless (left + block_size + block_size) > 400
  end

  def move_up
    rotate_counterclockwise unless (top + block_size) >= 600
  end

  def move_down
    move(0, block_size) unless (top + block_size) >= 600
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
      [true, true, true, true],
      [false, false, false, false]
    ]
  end
end

Shoes.app width: 400, height: 620, resizable: false do
  background white
  rect(0, 600, 400, 20, fill: red)
  @block_size = 40

  renderer = Proc.new do |b|
    debug "rendering"
    @block_shape.remove if !@block_shape.nil?
    @block_shape = shape_for(b)
  end

  def shape_for(block)
    shape do
      fill "#0ff"
      block.shape.each_with_index do |row, y|
        row.each_with_index do |col, x|
          rect(block.left + x * @block_size, block.top + y * @block_size, @block_size, @block_size) if col
        end
      end
    end
  end

  @block = Iblock.new(renderer)

  @anim = animate 1 do
    if (@block.top + @block.block_size) >= 600
      @anim.stop and alert('Done!')
      break
    end

    @block.move_down
  end

  keypress do |key|
    if key == :left
      @block.move_left
    elsif key == :right
      @block.move_right
    elsif key == :up
      @block.move_up
    elsif key == :down
      @block.move_down
    end
  end
end
