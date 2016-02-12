class Colour
  BLACK = [0,0,0]
  WHITE = [1,1,1]
  BLUE  = [0,0,1]

  def self.new(rgb)
    return Vec.new(rgb)
  end
end
