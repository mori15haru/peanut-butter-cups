require 'rmagick'

require './colour'
require './sphere'
require './ray'

include Magick

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

if __FILE__ == $0
  image = Image.new(200, 200)
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
