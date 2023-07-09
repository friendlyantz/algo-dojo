require_relative 'test_case_1'
puts ANTON
# q = [5, 1, 2, 3, 7, 8, 6, 4]
# q = [1, 2, 5, 3, 7, 8, 6, 4]
q = ARRAY_1
q.map! { |element| element.to_i }
# p q

def minimumBribes(q)
  bribes_counter = 0
  q.map! { _1 - 1}
  (q.size - 1).downto(0) do |i|
    if (q[i] - i) > 2
      puts 'Too chaotic'
      break
    end
    ahead_of_it = q[i] - 2
    (ahead_of_it..i).each do |j|
      next if j < 0
      bribes_counter += 1 if q[j] > q[i]
    end 
  end
  puts bribes_counter
end

minimumBribes(q)
