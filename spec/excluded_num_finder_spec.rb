require 'rspec'
require_relative  '../src/excluded_num_finder'

describe 'Find and return excluded number' do

  it 'returns excluded number' do
    excluded = SecureRandom.random_number(10000)
    expect(ExcludedNumFinder.find_by_subtraction(input_ary(excluded))).to eq excluded
  end

end

def input_ary(excluded)
  ary = Array(1..10000)
  ary.delete(excluded)
  ary.shuffle!
end
