###################################
# Ambient light only
###################################

INFINITY = 1000

def render(pixels)
  pixels.each do |pix|
    pix.colour = ray_tracer(pix.ray)
  end
end

class Colour
  BLACK = [0,0,0]
  WHITE = [1,1,1]
  BLUE  = [0,0,1]

  def initialize(rgb)
    @r, @g, @b = rgb
  end

  def set_colour(rgb)
    @r, @g, @b = rgb
  end
end

class AmbientLight
  def self.intensity
    Colour.new([1.0,1.0,1.0])
  end
end

class Ray
  def initialize
    @org = [0, 0, 0]
    @dir = [0, 0, 0]
  end

  def intersect(objects)
    objects.min_by { |obj| obj.intersect(self) } # should ignore nil
  end
end

class Sphere
  def initialize
    @colour = Colour.new
    @org = [50,50,50]
    @r = 10
  end

  def intersect(ray)
    distance = dis(ray)
    #and not behind
    if distance <= @r
      return distance
    else
      return nil 
    end
  end

  private

  def dis(ray)
    # line  L  = ray.org + ray.dir * t
    #          = Q + R * t
    # point Q' = Q + R
    # point P  = @org
    #
    # theta = angle between QP and QQ'
    # dis   = |QP| * sin(theta)
    #       = |QP X QQ'| / |QQ'| 
  end

end

module RayTracer

  W = 100
  H = 100
  MAX_RAY_DEPTH = 5 
  BACKGROUND = Colour.new(Colour::BLACK) 

  pixels = Array.new(W){Array.new(H, Colour.new(0, 0, 0)}
  objects = [ Sphere.new, Sphere.new ]
  rays[W][H]

  def ray_traycer(ray)
    object = ray.closest_object(objects)

    if object
      object.colour * AmbientLight.colour
    else
      BACKGROUND * AmbientLight.colour
    end

  end

end
