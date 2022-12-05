n = gets.strip.to_i
array = gets.strip
array = array.split(' ').map(&:to_i)

num_swaps = 0

loop do
  swapped = false

  (n - 1).times do |i|
    next unless array[i] > array[i + 1]

    array[i], array[i + 1] = array[i + 1], array[i]
    swapped = true
    num_swaps += 1
  end

  break unless swapped
end

array

puts "Array is sorted in #{num_swaps} swaps."
puts "First Element: #{array[0]}"
puts "Last Element: #{array[-1]}"
