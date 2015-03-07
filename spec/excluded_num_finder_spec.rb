require 'rspec'
require_relative '../src/excluded_num_finder'

describe 'ExcludedNumFinder' do
  describe 'find by subtraction' do
    context 'finds and returns excluded number from a number array' do
      it 'returns excluded number' do
        excluded = SecureRandom.random_number(10000)
        expect(ExcludedNumFinder.find_by_subtraction(input_ary(excluded))).to eq excluded
      end
    end

    describe 'error handling' do
      context 'raises an exception with an illegal argument' do
        it 'has more than 9999 elements' do
          excluded = SecureRandom.random_number(10000)
          ary = input_ary(excluded) << excluded
          expect { ExcludedNumFinder.find_by_subtraction(ary) }.to raise_error(ExcludedNumFinder::OutOfRangeError)
        end

        # 以下、バリデーション項目は多くありますが、ディスカッションの観点とはあまり関係ないと思われるため省略します。
        it 'has less than 9999 elements' do
          skip 'skipped'
        end
        it 'includes 10000 or more numbers' do
          skip 'skipped'
        end
        it 'includes 10001 or more' do
          skip 'skipped'
        end
        it 'includes a number 0 or less' do
          skip 'skipped'
        end
        it 'includes a number 10001 or more' do
          skip 'skipped'
        end
        it 'includes incalculable element' do
          skip 'skipped'
        end
      end
    end
  end

  describe 'find by deletion' do
    context 'finds and returns excluded number from a number array' do
      it 'returns excluded number' do
        excluded = SecureRandom.random_number(10000)
        expect(ExcludedNumFinder.find_by_deletion(input_ary(excluded))).to eq excluded
      end
    end
  end

  describe 'find by search' do
    context 'finds and returns excluded number from a number array' do
      it 'returns excluded number' do
        excluded = SecureRandom.random_number(10000)
        expect(ExcludedNumFinder.find_by_search(input_ary(excluded))).to eq excluded
      end
    end
  end

end

def input_ary(excluded)
  ary = Array(1..10000)
  ary.delete(excluded)
  ary.shuffle!
end
