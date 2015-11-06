module CellState
  ALIVE = true 
  DEAD = false
end

class Cell
  attr_accessor :x, :y, :pos, :state

  def initialize(state, pos)
    @state = state
    @x = pos[0]
    @y = pos[1]
    @pos = pos
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
  
  attr_accessor :l_cands, :d_cands

  def initialize(initial_alive_cells)
    @l_cands = initial_alive_cells
    @d_cands = []
  end

  def add_d_cells
    @l_cands.each do |c|
      @@offsets.each do |dx, dy|
        pos = [c.x + dx, c.y + dy]
        @d_cands << Cell.new(CellState::DEAD, pos) if !@l_cands.map{|c| c.pos}.include?(pos)
      end
    end
    @d_cands = @d_cands.uniq
  end

  def update_cells
    add_d_cells
    update_alive_cells(@l_cands)
    update_dead_cells(@d_cands)
    @l_cands = @l_cands.select{|c| c.state == CellState::ALIVE}.uniq
    @d_cands = @d_cands.select{|c| c.state == CellState::ALIVE}.uniq
    @l_cands = @l_cands + @d_cands
  end

  private
  
  def update_dead_cells(cells)
    cells.each do |c|
      if DEAD_TO_ALIVE == (n_alive_neighbors(c))
        c.to_alive
      end
    end
  end

  def update_alive_cells(cells)
    cells.each do |c|
      if ALIVE_TO_ALIVE.include?(n_alive_neighbors(c))
        c.to_alive
      else
        c.to_dead
      end
    end
  end

  def n_alive_neighbors(cell)
    return @@offsets.map{|dx, dy| [cell.x + dx, cell.y + dy]}.select{|c| @l_cands.include?(c)}.count
  end
end

c1 = Cell.new(CellState::ALIVE, [-1,0])
c2 = Cell.new(CellState::ALIVE, [0,0])
c3 = Cell.new(CellState::ALIVE, [1,0])

game = Grid.new([c1,c2,c3])

game.update_cells
puts game.l_cands.map{|c| c.pos}.to_s
