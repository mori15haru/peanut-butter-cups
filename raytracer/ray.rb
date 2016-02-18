require './one_light'

class Ray
  attr_accessor :org, :dir

  def initialize(org, dir)
    @org = org
    @dir = dir.normalise
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
    intersection = objects.inject([nil, Float::INFINITY]) do |pair, obj|
      t = obj.intersects(self)
      if pair.last > t 
        pair = [obj, t]
      end 
      pair
    end

    nvl(intersection, Float::INFINITY)
  end

  def nvl(val, nvl)
    val.last == nvl ? nil : [val.first, org + dir * val.last] 
  end
  
  def in_shadow?(objects)
    objects.any? { |obj| obj.intersects(self) != Float::INFINITY }    
  end

end

