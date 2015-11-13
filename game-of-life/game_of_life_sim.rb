require 'gosu'
require './game_of_life'

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480
  def initialize
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Game of Life"
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
    c1 = Cell.new(CellState::ALIVE, [31,24])
    c2 = Cell.new(CellState::ALIVE, [32,24])
    c3 = Cell.new(CellState::ALIVE, [33,24])
    
    @cells = [c1, c2, c3]
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

window = SimWindow.new
window.show
