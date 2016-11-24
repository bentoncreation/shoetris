Shoes.app width: 400, height: 620, resizable: false do
  background blue
  rect 0, 600, 400, 20, fill: black
  @block = rect(200, 0, 40, 40, fill: white)

  def left(block)
    block.move block.left - 40, block.top unless (block.left - 40) < 0
  end

  def right(block)
    block.move block.left + 40, block.top unless (block.left + 80) > 400
  end

  def down(block)
    block.move block.left, block.top + 40 unless (@block.top + 40) >= 600
  end

  @anim = animate 1 do
    if (@block.top + 40) >= 600
      @anim.stop and alert('Done!')
      break
    end

    @block.move @block.left, @block.top + 40
  end

  keypress do |key|
    if key == :left
      left(@block)
    elsif key == :right
      right(@block)
    elsif key == :down
      down(@block)
    end
  end
end
