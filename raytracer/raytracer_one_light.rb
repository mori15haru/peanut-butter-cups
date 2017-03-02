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
  MAX_RAY_DEPTH = 4 

  AMBIENT    = Colour.new([1.0, 1.0, 1.0])
  BACKGROUND = Colour.new(Colour::GREY)
  SHADOW     = Colour.new(Colour::BLACK)
  RED        = Colour.new(Colour::RED)
  GREEN      = Colour.new(Colour::GREEN)
  BLUE       = Colour.new(Colour::BLUE)
  BRIGHT     = Colour.new(Colour::BRIGHT) 
  # Sphere#initialize(centre, r, colour, reflectivity, material)
  # @ka, @kr, @kd, @ks = material
  # One light at Vec.new([0,300,200])
  @@objects = [
    Sphere.new([200,000,400], 50, BLUE, [0.5,0.5,0.1,0.8]),
    Sphere.new([0,-200,400], 50, GREEN, [0.5,0.5,0.1,0.8]),
    Sphere.new([-200,100,600], 200, RED, [0.6,0.7,0.1,0.4]),
  ]

  @@pixels = Array.new(W) {
    Array.new(H, BACKGROUND)
  }

  def self.render
    @@pixels.each_with_index do |pix_arr, i|
      pix_arr.each_index do |j|
        ray = Ray.pixel_ray(j-W/2, -i+H/2)
        @@pixels[i][j] = trace(ray, 0, @@objects) 
      end
    end

    return @@pixels
  end

  def self.trace(ray, depth, others)

    hit = ray.intersects(others)

    colour = SHADOW
    
    return colour + SHADOW if !hit
    return colour + SHADOW if !(depth < MAX_RAY_DEPTH)

    id = [hit.normal.inner_prod(hit.shadow_ray.dir), 0].max
    is = [(-ray.dir.inner_prod(hit.reflected_ray.dir))**7, 0].max

    colour = colour + hit.colour * hit.obj.ka
    
    if !hit.in_shadow?(get_others(hit.obj)) 
#      l = (hit.point - OneLight.org).length
      colour = colour + hit.colour * (id * hit.obj.kd + is * hit.obj.ks)
#      colour /= l**2
    end

    return trace(hit.reflected_ray, depth + 1, get_others(hit.obj)) * hit.obj.kr + colour * (1 - hit.obj.kr)
  end

  def self.get_others(one)
    @@objects.reject { |obj| obj == one } 
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

