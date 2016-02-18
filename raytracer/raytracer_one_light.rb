require 'gosu'

require './colour'
require './sphere'
require './ray'
require './one_light'

###################################
# One light source
###################################

class RayTracer

  W = 400
  H = 400
  MAX_RAY_DEPTH = 5 
  BACKGROUND = Colour.new(Colour::GREY) 
  SHADOW = Colour.new(Colour::BLACK)

  @@objects = [
    Sphere.new([100,100,100]),
    Sphere.new([50,50,50]),
    Sphere.new([-100,100,100])
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
    intersection = ray.intersects(@@objects)

    if intersection 
      shadow_ray = Ray.get(intersection.last, OneLight.org)
      if !shadow_ray.in_shadow?(@@objects)
        return intersection.first.colour * OneLight::intensity
      else
        return SHADOW
      end
    end
    
    return BACKGROUND
  end

end

=begin
if __FILE__ == $0
  RayTracer.render
end
=end

class SimWindow < Gosu::Window
  @@w = 400 
  @@h = 400
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

