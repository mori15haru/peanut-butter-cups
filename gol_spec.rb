module CellState
  ALIVE = true 
  DEAD = false
end

class Cell
  def initialize(state, pos)
    @state = state
    @x = pos[0]
    @y = pos[1]
  end

  def to_alive
    @state = CellState::ALIVE
  end

  def to_dead
    @state = CellState::DEAD
  end
end

class Grid
  @@offsets = [-1, 0, 1].repeated_permutation(2).to_a.delete_if{|x| x == [0, 0]} 
  ALIVE_TO_ALIVE = [2, 3]
  DEAD_TO_ALIVE = 3
  def initialize(initial_alive_cells)
    @alive_cells = initial_alive_cells
    @l_cands = []
    @d_cands = []
  end

  def update_cells
    update_alive_cells(l_cands)
    update_dead_cells(d_cands)
  end

  private
  
  def update_alive_cells(cands)
    cands.each do |c|
      if DEAD_TO_ALIVE == (n_alive_neighbors(c))
        @alive_cells << c
      end
    end
  end

  def update_dead_cells(cands)
    cands.each do |c|
      if ALIVE_TO_ALIVE.include?(n_alive_neighbors(c))
        @alive_cells << c
      end
    end
  end

  def n_alive_neighbors(cell)
    return @@offsets.map{|dx, dy| [cell.x + dx, cell.y + dy]}.select{|c| @alive_cells.include?(c)}.count
  end
end
