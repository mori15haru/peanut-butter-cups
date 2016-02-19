class Ray
  attr_accessor :org, :dir

  def initialize(org, dir)
    @org = org
    @dir = dir
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
      else
        pair
      end
    end

    nvl(intersection, Float::INFINITY)
  end

  def nvl(val, nvl)
    val.last == nvl ? nil : val.first
  end
end


