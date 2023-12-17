class GearLocator
  def initialize(input)
    @input = input
  end

  def call
    coordinates = []
    @input.each_with_index do |row, row_index|
      row.each_with_index do |char, col_index|
        coordinates << [row_index, col_index] if char == '*'
      end
    end
    coordinates
  end
end
