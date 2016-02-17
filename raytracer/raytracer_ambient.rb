require 'gosu'

require './colour'
require './sphere'
require './ray'

###################################
# Ambient light only
###################################

class AmbientLight
  def self.intensity
    Colour.new([1.0,1.0,1.0])
  end
end

class RayTracer

  W = 200
  H = 200
  MAX_RAY_DEPTH = 5 
  BACKGROUND = Colour.new(Colour::GREY) 

  @@objects = [
    Sphere.new([100,100,100]),
    Sphere.new([50,50,50])
  ]
  
  @@pixels = Array.new(W) {
    Array.new(H, BACKGROUND)
  }

  def self.render   
    @@pixels.each_with_index do |pix_arr, i|
      pix_arr.each_index do |j| 
        ray = Ray.pixel_ray(j-W/2, -i+H/2) 
        @@pixels[i][j] = ray_tracer(ray)
      end
    end

    return @@pixels
  end

  def self.ray_tracer(ray)
    object = ray.intersects(@@objects)

    if object
      object.colour * AmbientLight::intensity
    else
      BACKGROUND * AmbientLight::intensity
    end
  end

end

=begin
if __FILE__ == $0
  RayTracer.render
end
=end

class SimWindow < Gosu::Window
  @@w = 200 
  @@h = 200
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
        Gosu::draw_rect(j, i, 1, 1, Gosu::Color.rgb(pix.x, pix.y, pix.z))
      end
    end
  end

end

if __FILE__ == $0
  window = SimWindow.new(ARGV[0].to_i)
  window.show
end

