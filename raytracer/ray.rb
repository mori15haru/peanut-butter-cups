require './one_light'

class Intersection
  attr_accessor :ray, :obj, :point 

  def initialize(ray, obj, point)
    @ray = ray
    @obj = obj
    @point = point
  end

  def reflective?
    @obj.reflectivity > 0
  end

  def reflectivity
    @obj.reflectivity
  end

  def in_shadow?(others)
    from_itself? || from_others?(others)
  end

  def reflected_ray
    dir = ray.dir - normal * 2.0 * (normal.inner_prod(ray.dir))
    Ray.new(point, dir)
  end

  def shadow_ray
    @shadow_ray ||= Ray.get(point, OneLight.org)
  end

  def colour
    @obj.colour
  end

  def normal
    @normal ||= (point - @obj.centre).normalise
  end

  private

  def from_itself?
    temp = shadow_ray.in_shadow_temp(obj)
    temp > 0
  end

  def from_others?(others)
    shadow_ray.in_shadow?(others)
  end
end

class Ray
  attr_accessor :org, :dir

  def initialize(org, dir)
    @org = org
    @dir = dir.normalise
    @intersection = nil
  end

  def self.get(v, u)
    dir = u - v
    return Ray.new(v, dir)
  end

  def self.pixel_ray(i, j)
    from = Vec.new([0,0,-500])
    to = Vec.new([i,j,0])

    dir = to - from
    Ray.new(from, dir)
  end

  def intersects(objects)
    obj, t = objects.inject([nil, Float::INFINITY]) do |pair, obj|
      t = obj.intersects(self)
      if pair.last > t
        pair = [obj, t]
      else
        pair
      end
    end

    @intersection = Intersection.new(self, obj, org + dir * t) if obj
  end

  def in_shadow?(objects)
    objects.any? { |obj| obj.intersects(self) != Float::INFINITY }
  end

  def in_shadow_temp(object)
    object.intersects_temp(self)
  end

end

