require './vector'

class Colour
  BLACK = [0,0,0]
  WHITE = [255,255,255]
  BLUE  = [0,0,255]
  GREY = [192,192,192]

  def self.new(rgb)
    return Vec.new(rgb)
  end
end
