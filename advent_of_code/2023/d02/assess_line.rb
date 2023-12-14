# Description: Round assessor
class AssessLine
  def initialize(input)
    @input = input
  end

  def call
    if assess_subserts_separately
      { true => @input.keys.first }
    else
      { false => @input.keys.first }
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
end
