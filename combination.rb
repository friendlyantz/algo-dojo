combination = lambda { |a|
  lambda do |b|
    (a - b + 1..a).inject(:*) / (1..b).inject(:*)
  end
}
# ========
n = gets.to_i
r = gets.to_i
nCr = combination.call(n)
puts nCr.call(r)
