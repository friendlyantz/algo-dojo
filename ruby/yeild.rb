candy = [2, 4, 6, 8]

candy_times_three = candy.map do |candy|
  candy * 3
end

puts candy_times_three

def intro(name)
  puts 'we are in the METHOD'
  yield(name)
  yield('Amanda')
  yield(name)
  yield('John')
  puts 'we are back in the METHOD'
end

intro('Anton') do |n|
  puts "Hello, #{n}"
end
