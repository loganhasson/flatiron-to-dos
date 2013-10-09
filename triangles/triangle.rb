class TriangleError < StandardError
end

class Triangle

  attr_accessor :a, :b, :c

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end

  def kind
    sides = [a,b,c]
    ineq = [a+b > c, a+c > b, b+c > a]

    if sides.min <= 0 || ineq.include?(false)
      raise TriangleError
    end

    if a == b && b == c
      :equilateral
    elsif a != b && a != c && b != c
      :scalene
    elsif (a == b && b != c) || (b == c && c != a) || (a == c && c != b)
      :isosceles
    end
  end
  
end