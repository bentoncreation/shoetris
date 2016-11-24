class Iblock
  attr_reader :color
  attr_accessor :left, :top, :shape

  def initialize
    @left = 0
    @top = 0
    @shape = default_shape
  end

  def color
    "#0ff"
  end

  def block_size
    40
  end

  def rotate
    @shape = @shape.transpose
  end

  private

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
  @block = Iblock.new

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

  def rotate(block)
    block.rotate
    render(block)
  end

  def move(block, move_left, move_top)
    block.left += move_left
    block.top += move_top
    render(block)
  end

  def render(block)
    @block_shape.remove if !@block_shape.nil?
    @block_shape = shape_for(block)
  end

  def left(block)
    move(block, -@block_size, 0) unless (block.left - @block_size) < 0
  end

  def right(block)
    move(block, @block_size, 0) unless (block.left + @block_size + @block_size) > 400
  end

  def up(block)
    rotate(block) unless (@block.top + @block_size) >= 600
  end

  def down(block)
    move(block, 0, @block_size) unless (block.top + @block_size) >= 600
  end

  render(@block)

  @anim = animate 1 do
    if (@block.top + @block_size) >= 600
      @anim.stop and alert('Done!')
      break
    end

    down(@block)
  end

  keypress do |key|
    if key == :left
      left(@block)
    elsif key == :right
      right(@block)
    elsif key == :up
      up(@block)
    elsif key == :down
      down(@block)
    end
  end
end
