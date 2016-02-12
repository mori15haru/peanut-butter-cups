class Ray
  attr_accessor :org, :dir

  def initialize(org, dir)
    @org = org
    @dir = dir
  end

  def intersect(objects)
    objects.min_by { |obj| obj.intersect(self) } # should ignore nil
  end
end


