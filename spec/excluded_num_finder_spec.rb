require 'rspec'
require_relative '../src/excluded_num_finder'

describe 'ExcludedNumFinder' do
  let(:excluded) { SecureRandom.random_number(10000) }
  let(:input_ary) { build_input_ary(excluded) }

  describe 'find by subtraction' do
    context 'finds and returns excluded number from a number array' do
      it 'returns excluded number' do
        expect(ExcludedNumFinder.find_by_subtraction(input_ary)).to eq excluded
      end
    end

    describe 'error handling' do
      context 'raises an exception with an illegal argument' do
        # 以下、バリデーションテストの実装については、1例を除いて省略します。
        # (ディスカッションの観点とはあまり関係ないと思われるため)
        # 残りは観点のみ記述してPendingしておきます。

        describe 'illegal number of elements' do
          it 'has more than 9999 elements' do
            excluded = SecureRandom.random_number(10000)
            ary = input_ary << excluded
            expect { ExcludedNumFinder.find_by_subtraction(ary) }.to raise_error(ExcludedNumFinder::OutOfRangeError)
          end

          it 'has less than 9999 elements'
        end

        describe 'illegal range of numbers' do
          it 'includes a number 0 or less'
          it 'includes a number 10001 or more'
        end

        describe 'illegal type of elements' do
          it 'includes non-integer element'
        end
      end
    end
  end

  describe 'find by deletion' do
    context 'finds and returns excluded number from a number array' do
      it 'returns excluded number' do
        expect(ExcludedNumFinder.find_by_deletion(input_ary)).to eq excluded
      end
    end
  end

  describe 'find by search' do
    context 'finds and returns excluded number from a number array' do
      it 'returns excluded number' do
        expect(ExcludedNumFinder.find_by_search(input_ary)).to eq excluded
      end
    end
  end

end

def build_input_ary(excluded)
  ary = Array(1..10000)
  ary.delete(excluded)
  ary.shuffle!
end
