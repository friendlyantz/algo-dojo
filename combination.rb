combination = -> (a) {
  -> (b) do
      (a-b+1..a).inject(:*) / (1..b).inject(:*)
  end
}
# ========
n = gets.to_i
r = gets.to_i
nCr = combination.(n)
puts nCr.(r)