require './vector'

class Colour
#  BLACK = [0,0,0]
#  WHITE = [255,255,255]
#  BLUE  = [0,0,255]
#  GREY = [192,192,192]

  BLACK = [0,0,0]
  WHITE = [1,1,1]
  BLUE  = [0,0,1]
  GREY = [192/255.0,192/255.0,192/255.0]

  def self.new(rgb)
    return Vec.new(rgb)
  end
end
