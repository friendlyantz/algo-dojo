def hourglassSum(arr)
  x = 0
  y = 0
  max = -999
  4.times do |x|
    puts ''
    4.times do |y|
      row1 = arr[x][y] + arr[x][y + 1] + arr[x][y + 2]
      row2 = arr[x + 1][y + 1]
      row3 = arr[x + 2][y] + arr[x + 2][y + 1] + arr[x + 2][y + 2]
      sum = row1 + row2 + row3
      # puts 'max doesnt exist' if !max
      # max = 90000 if !max

      puts "||||line #{x + 1}, row #{y + 1}: sum: #{sum}. max: #{max}"
      max = sum if sum >= max
    end
  end

  puts "max: #{max}"
end
arr = [
  [1, 1, 1, 0, 0, 0],
  [0, 1, 0, 0, 0, 0],
  [1, 1, 1, 0, 0, 0],
  [0, 0, 2, 4, 4, 0],
  [0, 0, 0, 2, 0, 0],
  [0, 0, 1, 2, 4, 0]
]

arr2 = [
  [0, -4, -6, 0, -7, -6],
  [-1, -2, -6, -8, -3, -1],
  [-8, -4, -2, -8, -8, -6],
  [-3, -1, -2, -5, -7, -4],
  [-3, -5, -3, -6, -6, -6],
  [-3, -6, 0, -8, -6, -7]
]
puts arr
hourglassSum(arr2)
