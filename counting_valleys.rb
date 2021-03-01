
path = "UDDDUDUU"

def countingValleys(steps, path)
  current_depth = 0
  valley_counter = 0
    # Write your code here
    
    path.split(//).each do |step|
        if step == "D"
          current_depth -= 1
          valley_counter += 1 if current_depth == 0
        elsif step == "U"
          p step
          # p current_depth
            current_depth = current_depth + 1
            valley_counter += 1 if current_depth == 0
        else
            puts "error"
        end
    end
    p valley_counter / 2 + valley_counter%2
end

countingValleys(8, path)
