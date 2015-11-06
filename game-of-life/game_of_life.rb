module CellState
  ALIVE = true
  DEAD  = false
end

class Cell
  ALIVE_TO_ALIVE = [2, 3]
  DEAD_TO_ALIVE  = 3

  attr_accessor :x, :y, :pos, :state, :n_neighbors

  def initialize(state, pos)
    @state = state
    @pos   = pos
    @x, @y = pos[0], pos[1]
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
  @@offsets = [-1, 0, 1].repeated_permutation(2).to_a.delete_if{|p| p == [0, 0]} 

  attr_accessor :cands

  def initialize(initial_alive_cells)
    @cands = initial_alive_cells
  end

  def update_cells
    update_cands 
    current_alive_cells_map = alive_cells_map.clone
    @cands.each do |cell|
      n_neighbors = number_of_alive_neighbors(cell, current_alive_cells_map)
      cell.update_number_of_neighbors(n_neighbors)
      cell.update_state
    end
  end

  def alive_cells_map
    alive_cells.map{|c| c.pos}
  end

  def to_s
    alive_cells_map.to_s
  end

  private

  def update_cands
    # Candidates currently alive
    @cands = alive_cells
    # Candidates currently dead
    dead_cands = []
    
    @cands.each do |c|
      @@offsets.each do |dx, dy|
        cand_pos = [c.x + dx, c.y + dy]
        if !alive_cells_map.include?(cand_pos) && !dead_cands.map{|c| c.pos}.include?(cand_pos)
          dead_cands << Cell.new(CellState::DEAD, cand_pos) 
        end
      end
    end
    @cands += dead_cands
  end

  def alive_cells
    @cands.select{|c| c.state == CellState::ALIVE}
  end

  def number_of_alive_neighbors(cell, current_alive_cells_map)
    @@offsets.map{|dx, dy| [cell.x + dx, cell.y + dy]}.select{|c| current_alive_cells_map.include?(c)}.count
  end

end
