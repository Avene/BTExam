require 'rspec'
require_relative  '../src/excluded_num_finder'

describe 'Find and return excluded number' do

  it 'should return testing' do
    expect(ExcludedNumFinder.run).to eq 'env testing'
  end
end