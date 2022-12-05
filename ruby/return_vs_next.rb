def check(arg)
  results = []
  3.times do
    case arg
    when 'return'
      return results << 'hello from return' if true

      results << 'hey🎉 u dont wanna see me'
    when 'next'
      next results << 'hello from next' if true

      results << 'hey🎉 u dont wanna see me'
    else
      results << 'else case'
    end
  end
  results
end

RSpec.describe 'check' do
  it "'return' breaks out of the loop" do
    arg = 'return'
    expect(check(arg)).to eq ['hello from return']
  end

  it "'next' skips only 1 loop step" do
    arg = 'next'
    expect(check(arg)).to eq ['hello from next', 'hello from next', 'hello from next']
  end
end
