require './vector'

class Colour
  BLACK = [0,0,0]
  WHITE = [1,1,1]
  BLUE  = [0,0,1]
  GREY = [192.0/255,192.0/255,192.0/255]

  def self.new(rgb)
    return Vec.new(rgb)
  end
end
