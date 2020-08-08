# Intoduction
class Hello
  # Method like function
  def my_first_method
    puts "Hello, world!"
  end
end

# create object of the class
x = Hello.new
# call method
x.my_first_method

class MyClassA

  def m1
    777
  end

  # unusual sum
  def m2 (x,y)
    z = 777
    if x == y
      z
    else x + y
    end
  end

end

class MyClassB
  def m1
    7
  end

  def m3 x
    x.abs * 2 + self.m1
  end

end

class MyClassC
  def m1
    print "KeK "
    self
  end
  def m2
    print "LoL "
    self
  end
  def m3
    print "\n"
    self
  end
end
# ? = MyClassC.new -> ?.m1.m2.m3.m2.m1

class StateA
  def initialize(f=0) #=0 is default value if method is called with no argument
    @foo = f
  end
  def m1
    @foo = 0
  end
  def m2 x
    @foo += x
  end
  def foo
    @foo
  end
end

class WifeAmount
  Num_of_Wifes = 2

  # class variable starts with @@
  # they are shared by all objects
  def self.reset_bar
    @@bar = 0
  end

  def initialize(f=0)
    @foo = f
  end

  def m2 x
    @foo += x
    @@bar += 1
  end

  def foo
    @foo
  end

  def bar
    @@bar
  end
end


##
## Larger example
##

class MyRational

  def initialize(num,den=1)
    if den == 0
      raise "Division by zero"
    elsif den < 0
      @num = - num
      @den = - den
    else
      @num = num
      @den = den
      reduce # i.e self.reduce() but private
    end
  end

  def to_s
      ans = @num.to_s
      if @den !=1
        ans += "/"
        ans += @den.to_s
      end
      ans
  end

  def to_s2
    dens = ""
    dens = "/" + @den.to_s if @den !=1 #funny if syntax => e1 if e2 means do e1 if e2
    @num.to_s + dens
  end

  def to_s3
    "#{@num}#{if @den==1 then "" else "/" + @den.to_s end}"
  end

  # Imperative addition
  def add! r  # mutate self in-place
    a = r.num # only works b/c of protected methods below
    b = r.den # only works b/c of protected methods below
    c = @num
    d = @den
    @num = (a * d) + (b * c)
    @den = b * d
    reduce
    self # convinient for stringing calls
  end

  # Functional addition
  # makes a new rational
  # actually sugar for n.+(n1)
  def + r
    ans = MyRational.new(@num,@den)
    ans.add! r
    ans
  end

  protected # also public private
  # synt. sugar is attr_reader :num, :den
  # can't make it private b/c of the add! method above
  def num
    @num
  end
  def den
    @den
  end

  private
  def gcd (x,y) # recursive method
    if x == y
      x
    elsif x < y
      gcd(x,y-x)
    else
      gcd(y,x)
    end
  end

  def reduce
    if @num == 0
      @den = 1
    else
      d = gcd(@num.abs, @den) # method call on number
      @num = @num / d
      @den = @den / d
    end
  end

end

# top-level method for testing
def use_rationals
  r1 = MyRational.new(3,4)
  r2 = r1 + r1 + MyRational.new(-5,2)
  puts r2.to_s
  (r2.add! r1).add! (MyRational.new(1,-4))
  puts r2.to_s
  puts r2.to_s2
  puts r2.to_s3
end

#road to madness what is the class of Class of class of class ...

## ducktype example
# def mirrof_update pt
#     pt.x = pt.x * (-1)
# end
