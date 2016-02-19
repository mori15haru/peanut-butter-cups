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
      temp = shadow_ray.in_shadow_temp(intersection.first) 
      if temp != nil && temp > 0
        return SHADOW
      elsif !shadow_ray.in_shadow?(@@objects.reject{|obj| obj == intersection.first})
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

  image.write('result.jpg')
end

