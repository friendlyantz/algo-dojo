y = 1
while (input = gets)
  if input == "\n"
    puts 'Another one?'
  elsif input.chomp == '1'
    y += 1
  end
end
