require './vector'

class Colour

  BLACK = [0.0, 0.0, 0.0]
  WHITE = [1.0, 1.0, 1.0]
  RED   = [1.0, 0.0, 0.0]
  BLUE  = [0.0, 0.0, 1.0]
  GREY  = [192.0/255.0,192.0/255.0,192.0/255.0]
  BRIGHT= [0.3, 0.3, 0.3]  
  def self.new(rgb)
    return Vec.new(rgb)
  end

end

