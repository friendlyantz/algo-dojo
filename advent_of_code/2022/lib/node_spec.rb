require File.join(__dir__, 'node')
require 'pry'

RSpec.describe Node do
  it 'creates a node with correct data' do
    expect(Node.new('lala').data).to eq 'lala'
  end
end
