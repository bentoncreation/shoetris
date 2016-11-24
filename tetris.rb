Shoes.app width: 400, height: 620, resizable: false do
  background white
  rect(0, 600, 400, 20, fill: red)
  @block_size = 40
  @block = { left: 0, top: 0 }

  def shape_for(block)
    shape do
      fill blue
      rect(block[:left] + 0, block[:top] + 0, @block_size, @block_size)
      rect(block[:left] + 40, block[:top] + 0, @block_size, @block_size)
      rect(block[:left] + 80, block[:top] + 0, @block_size, @block_size)
      rect(block[:left] + 120, block[:top] + 0, @block_size, @block_size)
    end
  end

  def rotate(block)
  end

  def move(block, move_left, move_top)
    block[:left] += move_left
    block[:top] += move_top
    render(block)
  end

  def render(block)
    @block_shape.remove if !@block_shape.nil?
    @block_shape = shape_for(block)
  end

  def left(block)
    move(block, -@block_size, 0) unless (block[:left] - @block_size) < 0
  end

  def right(block)
    move(block, @block_size, 0) unless (block[:left] + @block_size + @block_size) > 400
  end

  def up(block)
    rotate(block) unless (@block[:top] + @block_size) >= 600
  end

  def down(block)
    move(block, 0, @block_size) unless (block[:top] + @block_size) >= 600
  end

  render(@block)

  @anim = animate 1 do
    if (@block[:top] + @block_size) >= 600
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
