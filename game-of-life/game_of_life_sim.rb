require 'gosu'
require './game_of_life'

module CellPattern
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
end

class SimWindow < Gosu::Window

  @@w = 640
  @@h = 480
  
  include CellPattern

  def initialize(pattern)
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Game of Life"

    @cells = CellPattern.blinker
    #self.send(pattern)
    self.generate_cells
  end

  def update
  end 

  def update_cells
    @game.update
    @cells = @game.alive_cells 
  end

  def draw
    @cells.each do |cell|
      Gosu::draw_rect(10.0*cell.pos.x, 10.0*cell.pos.y, 10, 10, Gosu::Color::WHITE)
    end
  end

  def generate_cells
    @game = GameOfLife.new(@cells)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbSpace
      update_cells
    end
  end

end

window = SimWindow.new('beacon')
window.show