def render
  rays.each do |ray|
    ray.pixel = ray_tracer(ray)
  end
end

module RayTracer

  W = 100
  H = 100
  BACKGROUND = black
  EYE = [0, 0, -10]

  objects = [Sphere.new, Sphere.new]
  rays[W][H]

  def ray_traycer(ray, depth)

    object = ray.visible_object(objects)

    if object #not nil
      if ray.in_shadow?
      else
      end
    else
    end
  end

end

class Light
  def initialize
    @brightness = 1.0
  end
end

class Ray
  def initialize
    @org = [0, 0, 0]
    @dir = [0, 0, 0]
  end

  def visible_object(objects)
    objects.min_by{ |object| object.intersect(self) }
  end

  def in_shadow?
  end

  def dis(v)
    10
  end
end

class Pixel
  def initialize
    @pos = [0, 0]
    @color = Color.new
  end
end

class Sphere
  def initialize
    @colour = Colour.new
    @r = 50.0
    @centre = [30, 30, 30]

    @refraction = 0.5
    @reflection = 0.5
  end

  def intersect(ray)
    ray.dis(@centre) <= @r
  end

end
