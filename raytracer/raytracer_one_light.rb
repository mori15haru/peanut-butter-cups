require 'rmagick'

require './colour'
require './sphere'
require './ray'
require './one_light'

include Magick

###################################
# One light source
###################################

class RayTracer

  W = 400
  H = 400
  MAX_RAY_DEPTH = 5

  BACKGROUND = Colour.new(Colour::GREY)
  SHADOW = Colour.new(Colour::BLACK)
  ENOUGH = Colour.new(Colour::RED)

  @@objects = [
    Sphere.new([100,100,100]),
    Sphere.new([-100,100,100])
  ]

  @@pixels = Array.new(W) {
    Array.new(H, BACKGROUND)
  }

  def self.render
    @@pixels.each_with_index do |pix_arr, i|
      pix_arr.each_index do |j|
        ray = Ray.pixel_ray(j-W/2, -i+H/2)
        @@pixels[i][j] = trace(ray, 0)
      end
    end

    return @@pixels
  end

  def self.trace(ray, depth, sphere = nil)
     
    return ENOUGH if !valid_depth
    
    others = @@objects.reject { |obj| obj == sphere }
    hit    = ray.intersects(others)
  
    return BACKGROUND if !hit

    if hit.reflective?
      return trace(hit.reflected_ray, next_depth, hit.obj) * hit.reflectivity + (hit.colour) * (1 - hit.reflectivity)
    else
      return SHADOW if hit.in_shadow?(others)
      return hit.colour
    end

  end 

  private

  def self.valid_depth
    lambda { depth > MAX_RAY_DEPTH }
  end 
  
  def self.next_depth
    lambda { depth + 1 }
  end

end

if __FILE__ == $0
  image = Image.new(400, 400)
  pixels = RayTracer.render

  pixels.each_with_index do |pix_arr, i|
    pix_arr.each_with_index do |pix, j|
      draw = Draw.new
      draw.fill = Pixel.new(
        pix.x * QuantumRange,
        pix.y * QuantumRange,
        pix.z * QuantumRange
      )
      draw.point(j,i)
      draw.draw(image)
    end
  end

  image.write('result.png')
end

