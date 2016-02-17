require 'gosu'
require './raytracer_ambient'

class SimWindow < Gosu::Window
  @@w = 100 
  @@h = 100
  def initialize(n)
    super @@w, @@h
    self.caption = "Ruby :: Gosu :: Raytracer :: Ambient"
    @pixels = RayTracer.render  
  end

  def update
  end

  def draw
    @pixels.each_with_index do |pix_arr, i|
      pix_arr.each_with_index do |pix, j|
        i = i + W/2
        j = -j + H/2
        Gosu::draw_rect(i, j, 1, 1, pix.arr)
      end
    end
  end

end

if __FILE__ == $0
  window = SimWindow.new(ARGV[0].to_i)
  window.show
end
