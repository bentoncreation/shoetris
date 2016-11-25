require "lib/tetris"

Shoes.app width: 400, height: 620, resizable: false do
  background gray

  render_piece = Proc.new do |b|
    b.rendered.remove if !b.rendered.nil?
    b.rendered = shape do
      fill b.color
      b.shape.each_with_index do |row, y|
        row.each_with_index do |col, x|
          rect(b.left + x * b.block_size, b.top + y * b.block_size, b.block_size, b.block_size) if col
        end
      end
    end
  end

  render_map = Proc.new do |map|
    map.rendered = shape do
      fill map.background_color
      rect(map.left, map.top, map.width * map.unit_size, map.height * map.unit_size)
    end
  end

  @map = Tetris::Map.new(render_map)
  @blocks = []

  @anim = animate 1 do
    if @current_block.nil? || @current_block.bottom >= 600
      @new_block = Tetris::TPiece.new(render_piece)
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
