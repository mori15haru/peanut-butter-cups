module CellPattern
  #Still lifes
  def self.block
    c1 = Cell.new(CellState::ALIVE, [31,24])
    c2 = Cell.new(CellState::ALIVE, [32,24])
    c3 = Cell.new(CellState::ALIVE, [31,25])
    c4 = Cell.new(CellState::ALIVE, [32,25])
    [c1, c2, c3, c4]
  end

  #Oscillator
  def self.blinker
    c1 = Cell.new(CellState::ALIVE, [31,24])
    c2 = Cell.new(CellState::ALIVE, [32,24])
    c3 = Cell.new(CellState::ALIVE, [33,24])
    [c1, c2, c3]
  end

  def self.toad
    c1 = Cell.new(CellState::ALIVE, [31,25])
    c2 = Cell.new(CellState::ALIVE, [32,25])
    c3 = Cell.new(CellState::ALIVE, [32,24])
    c4 = Cell.new(CellState::ALIVE, [33,25])
    c5 = Cell.new(CellState::ALIVE, [33,24])
    c6 = Cell.new(CellState::ALIVE, [34,24])
    [c1, c2, c3, c4, c5, c6]
  end

  def self.beacon
    c1 = Cell.new(CellState::ALIVE, [31,23])
    c2 = Cell.new(CellState::ALIVE, [32,23])
    c3 = Cell.new(CellState::ALIVE, [31,22])
    c4 = Cell.new(CellState::ALIVE, [32,22])
    c5 = Cell.new(CellState::ALIVE, [33,21])
    c6 = Cell.new(CellState::ALIVE, [34,21])
    c7 = Cell.new(CellState::ALIVE, [33,20])
    c8 = Cell.new(CellState::ALIVE, [34,20])
    [c1, c2, c3, c4, c5, c6, c7, c8]
  end

  #Spaceships
  def self.glinder
    c1 = Cell.new(CellState::ALIVE, [5,5])
    c2 = Cell.new(CellState::ALIVE, [3,6])
    c3 = Cell.new(CellState::ALIVE, [5,6])
    c4 = Cell.new(CellState::ALIVE, [4,7])
    c5 = Cell.new(CellState::ALIVE, [5,7])
    [c1, c2, c3, c4, c5]
  end
end