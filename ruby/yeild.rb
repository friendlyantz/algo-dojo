candy = [2, 4, 6, 8]

candy_times_three = candy.map do |candy|
  candy * 3
end

puts candy_times_three

def triple
  puts 'we are in the METHOD'
  yield
  puts 'we are back in the METHOD'
end

triple { puts 'we are in the BLOCK' }
