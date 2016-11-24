class Iblock
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
    "#0ff"
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
      [true, true, true, true],
      [false, false, false, false],
    ]
  end
end

Shoes.app width: 400, height: 620, resizable: false do
  background white
  rect(0, 600, 400, 20, fill: red)

  renderer = Proc.new do |b|
    b.rendered.remove if !b.rendered.nil?
    b.rendered = shape_for(b)
  end

  def shape_for(block)
    shape do
      fill block.color
      block.shape.each_with_index do |row, y|
        row.each_with_index do |col, x|
          rect(block.left + x * block.block_size, block.top + y * block.block_size, block.block_size, block.block_size) if col
        end
      end
    end
  end

  @blocks = []

  @anim = animate 1 do
    if @current_block.nil? || @current_block.bottom >= 600
      @new_block = Iblock.new(renderer)
      @blocks << @new_block
      @current_block = @new_block
      # @anim.stop and alert('Done!')
    else
      @current_block.move_down
    end
  end

  keypress do |key|
    if key == :left
      @current_block.move_left
    elsif key == :right
      @current_block.move_right
    elsif key == :up
      @current_block.move_up
    elsif key == :down
      @current_block.move_down
    end
  end
end
