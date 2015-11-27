require 'gosu'
require './game_of_life'
require './cell'
require './cell_pattern'

class SimWindow < Gosu::Window

  @@w = 640
  @@h = 480
  
  def initialize(pattern)
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Game of Life"

    @cells = CellPattern.send(pattern)
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

window = SimWindow.new(ARGV[0].to_s)
window.show