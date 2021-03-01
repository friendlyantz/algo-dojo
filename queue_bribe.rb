# q = [5, 1, 2, 3, 7, 8, 6, 4]
q = [1, 2, 5, 3, 7, 8, 6, 4]
p q

def minimumBribes(q)
    bribe_sum = 0
    bribing_counter = 0
    # max_shifted_number = 0
    bribe_streak = 0
    too_chaotic = 0
      q.each_with_index do |number, index|
        puts "#{number} checking for bribes. index: #{index}"

            if number > index +1 
                puts "#{number} CORRUBT. index: #{index}"
                bribe_streak = number - (index + 1)

                if bribe_streak <= 2
                    bribe_sum += bribe_streak
                else
                    too_chaotic = "Too chaotic"
                    puts too_chaotic
                end
            elsif number <= index +1 && q[index..8].any? {|element| element < number }
                # puts "basta"
                bribe_streak = q[index..8].count {|element| element < number }
                # p bribe_streak
                if bribe_streak <= 2
                    bribe_sum += bribe_streak
                else
                    too_chaotic = "Too chaotic"
                    puts too_chaotic
                end

            end
      end

    puts "finished"
    
    if too_chaotic == "Too chaotic"
        too_chaotic 
    else
        puts bribe_sum
    end
    
end

minimumBribes(q)