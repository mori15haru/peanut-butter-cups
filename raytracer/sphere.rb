require './colour'

class Sphere
  attr_accessor :colour
  
  def initialize(center=[50,50,50])
    @colour = Colour.new(Colour::BLUE)
    @centre = Vec.new(center) 
    @r = 10
  end

  def intersect(ray)
    #TO DO: not in behind the ray
    distance_to_centre = get_distance_to_centre(ray) 
    if distance_to_centre <= @r
      distance_to_sphere(distance_to_centre, ray)
    else
      Float::INFINITY 
    end
  end

  private
  
  def distance_to_sphere(dis, ray)
    l = @centre - ray.org
    m = Math::sqrt(l.abs**2 - dis**2) 
    n = Math::sqrt(@r**2 - dis**2) 
    return m - n
  end

  def get_distance_to_centre(ray)
    # line  L  = ray.org + ray.dir * t
    #          = Q + R * t
    # point P  = @org
    #
    # theta = angle between QP and R
    # dis   = |QP| * sin(theta)
    #       = |QP X R| / |R|
    a = (@centre - ray.org).outer_prod(ray.dir).abs
    b = (ray.dir).abs
    return a/b.to_f
  end

end
