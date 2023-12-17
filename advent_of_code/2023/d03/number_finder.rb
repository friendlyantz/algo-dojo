class NumberFinder
  def initialize(map, coordinates, gears: false)
    @map = map
    @coordinates = coordinates
    @gears = gears
  end

  def call
    numbers = []
    @coordinates.each do |line, column|
      numbers += check_neighbours(line, column)
    end
    numbers.uniq.map(&:keys).flatten
  end

  private

  def check_neighbours(line, column)
    found_nums = []
    ::NeighbourYield.all(@map, [line, column]) do |digit_line_no, digit_column_no|
      if integer?(digit_line_no, digit_column_no)
        partial_num = []
        partial_num << record_partail_num_and_coordinates(digit_line_no, digit_column_no)
        r = find_part_of_num_to_the_right(digit_line_no, digit_column_no, partial_num)
        l = find_part_of_num_to_the_left(digit_line_no, digit_column_no, partial_num)
        num = partial_num.map { _1.keys.first }.join.to_i
        coordinates = partial_num.map { _1.values.first }
        found_nums << { num => coordinates }
      end
    end

    if @gears
      if found_nums.uniq.size == 2
        multiplied_gear_ration = found_nums.uniq.map { _1.keys.first }.inject(:*)
        coordinates = found_nums.uniq.map { _1.values.first }
        [{ multiplied_gear_ration => coordinates }]
      else
        []
      end
    else
      found_nums.uniq
    end
  end

  def integer?(line, column)
    @map[line][column].is_a? Integer
  end

  def find_part_of_num_to_the_right(line, column, partial_num)
    (column + 1..@map.first.length - 1).each do |moved_column_no|
      break unless integer?(line, moved_column_no)

      partial_num.push record_partail_num_and_coordinates(line, moved_column_no)
    end
    partial_num
  end

  def find_part_of_num_to_the_left(line, column, partial_num)
    (column - 1).downto(0) do |moved_column_no|
      break unless integer?(line, moved_column_no)

      partial_num.unshift record_partail_num_and_coordinates(line, moved_column_no)
    end
    partial_num
  end

  def record_partail_num_and_coordinates(digit_x, digit_y)
    { @map[digit_x][digit_y] => [digit_x, digit_y] }
  end
end
