require './colour'
require './quadratic_equation'

class Sphere
  attr_accessor :colour, :centre, :ka, :kr, :kd, :ks

  def initialize(centre, r, colour, material)
    @centre = Vec.new(centre)
    @r = r 
    @colour = colour
    @ka, @kr, @kd, @ks = material
  end

  def intersects(ray)
    # line  L  = ray.org + ray.dir * t
    #          = Q + R * t
    # sphere S = |x - C| = r
    #
    # Find 't's that satisfy: |(Q - C) + R * t | = r
    a = ray.org - @centre
    b = ray.dir
    c = @r

    QuadraticEquation::Sphere::solve(a,b,c)
  end

  def intersects_temp(ray)
    # line  L  = ray.org + ray.dir * t
    #          = Q + R * t
    # sphere S = |x - C| = r
    #
    # Find 't's that satisfy: |(Q - C) + R * t | = r
    a = ray.org - @centre
    b = ray.dir
    c = @r

    QuadraticEquation::Sphere::solve_temp(a,b,c)
  end

end
