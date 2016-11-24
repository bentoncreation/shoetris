require "lib/tetris"

Shoes.app width: 400, height: 620, resizable: false do
  background white
  rect(0, 600, 400, 20, fill: gray)

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
      @new_block = Tetris::TPiece.new(renderer)
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
