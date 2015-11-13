module CellState
  ALIVE = true
  DEAD  = false
end

class Position
  attr_accessor :p, :x, :y

  def initialize(pos)
    @p = pos
    @x = pos[0]
    @y = pos[1]
  end

  def +(other)
    Position.new([@x + other.x, @y + other.y])
  end
end

class Cell
  ALIVE_TO_ALIVE = [2, 3]
  DEAD_TO_ALIVE  = 3

  attr_accessor :pos, :state, :n_neighbors

  def initialize(state, pos)
    @state = state
    @pos   = Position.new(pos)
  end

  def update_number_of_neighbors(n)
    @n_neighbors = n
  end

  def update_state
    if @state == CellState::ALIVE
      update_alive_cell
    else
      update_dead_cell
    end
  end

  private

  def update_dead_cell
    @state = CellState::ALIVE if DEAD_TO_ALIVE == n_neighbors
  end

  def update_alive_cell
    @state = CellState::DEAD unless ALIVE_TO_ALIVE.include?(n_neighbors)
  end

end

class GameOfLife
  @@offsets = [-1, 0, 1].repeated_permutation(2).to_a.delete_if{|p| p == [0, 0]}.map{|pos| Position.new(pos)}

  attr_accessor :cands, :alive_cells

  def initialize(initial_alive_cells)
    @alive_cells = initial_alive_cells
    @cands = nil
  end

  def update
    set_cands
    update_cells
    set_alive_cells
  end

  def to_s
    alive_cells_map.to_s
  end

  private

  def update_cells
    current_alive_cells_map = alive_cells_map.clone
    @cands.each do |cell|
      cell.update_number_of_neighbors(number_of_alive_neighbors(cell, current_alive_cells_map))
      cell.update_state
    end
  end

  def get_dead_cands
    alive_cells_pos
      .product(@@offsets)
      .map{|cand, offset| (cand + offset).p}
      .uniq
      .select{|pos| !alive_cells_map.include?(pos)}
      .map{|pos| Cell.new(CellState::DEAD, pos)}
  end

  def set_cands
    @cands = alive_cells + get_dead_cands
  end

  def number_of_alive_neighbors(cell, current_alive_cells_map)
    @@offsets
      .map{|offset| cell.pos + offset}
      .select{|c| current_alive_cells_map.include?(c.p)}
      .count
  end

  def alive_cells_pos
    @alive_cells.map{|c| c.pos}
  end

  def alive_cells_map
    @alive_cells.map{|c| c.pos.p}
  end

  def set_alive_cells
    @alive_cells = @cands.select{|c| c.state == CellState::ALIVE}
  end

end
