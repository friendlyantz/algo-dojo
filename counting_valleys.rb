path = 'DDUUDDUDUUUD'

def countingValleys(_steps, path)
  current_depth = 0
  valley_counter = 0
  # Write your code here
  previous_depth = 0
  path.split(//).each do |step|
    if step == 'D'
      current_depth -= 1
      # valley_counter += 1 if current_depth == 0 && previous_depth == 1
      p current_depth.to_s + step * 2 + valley_counter.to_s
      previous_depth = current_depth
    elsif step == 'U'
      current_depth += 1
      valley_counter += 1 if current_depth == 0 && previous_depth == -1
      p current_depth.to_s + step + valley_counter.to_s
      previous_depth = current_depth
    else
      puts 'error'
    end
  end
  p valley_counter
end

countingValleys(8, path)
