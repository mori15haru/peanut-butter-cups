require './colour'
require './quadratic_equation'

class Sphere
  attr_accessor :colour

  def initialize(centre)
    @colour = Colour.new(Colour::BLUE)
    @centre = Vec.new(centre)
    @r = 10
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
end
