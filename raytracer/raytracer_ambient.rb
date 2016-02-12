###################################
# Ambient light only
###################################

INFINITY = 1000

def render(pixels)
  pixels.each do |pix|
    pix.colour = ray_tracer(pix.ray)
  end
end

class AmbientLight
  def self.intensity
    Colour.new([1.0,1.0,1.0])
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
