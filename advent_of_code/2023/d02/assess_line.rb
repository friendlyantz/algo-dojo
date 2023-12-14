# Description: Round assessor
class AssessLine
  def initialize(input)
    @input = input
  end

  def call
    if assess_subserts_separately && assess_subserts_sum
      @input.each_key { |k| @input[k] = true }
    else
      @input.each_key { |k| @input[k] = false }
    end
  end

  def assess_subserts_separately
    result = true
    @input.values.first.map do |subset|
      unless LimitAssessor.new(subset).call
        result = false
        break
      end
    end
    result
  end

  def assess_subserts_sum
    array = @input.values.first
    result = array.each_with_object({ red: 0, green: 0, blue: 0 }) do |hash, total|
      total[:red] += hash[:red]
      total[:green] += hash[:green]
      total[:blue] += hash[:blue]
    end

    LimitAssessor.new(result).call
  end
end
