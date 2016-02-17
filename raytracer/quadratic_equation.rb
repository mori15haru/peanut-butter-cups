module QuadraticEquation
  module Sphere

    def self.real_solutions(a,b,d)
      t1 = (-b + Math::sqrt(d))/a
      t2 = (-b - Math::sqrt(d))/a
      
      return t1, t2
    end

    def self.solve_even(a,b,c)
      d = b**2 - a*c

      if a == 0 || d < 0
        return Float::INFINITY
      end

      t = self.real_solutions(a,b,d).select { |e| e >= 0 }.min
      return t || Float::INFINITY
    end

    def self.solve(p,q,r)
      # |P + Q * t| = r
      # (Px2 + Py2 + Pz2) + 2t(PxQx + PyQy + PzQz) + t2(Qx2 + Qy2 + Qz2) = r2

      c = p.square_length - r**2
      b = p.inner_prod(q)
      a = q.square_length

      solve_even(a,b,c)
    end
  end
end
