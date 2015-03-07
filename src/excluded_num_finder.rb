class ExcludedNumFinder
  # 合計値から引数を順に減算し、残った値を除外されていた値として得る方法
  # 計算量はO(n)
  # メモリ占有は 引数 + Fixnum2つ分(=Fixnum 10002個分)
  # コードも実質1行(Injectするだけ)ですが、以下のデメリットがあります。
  # * 引数が信頼できない場合、厳密にバリデーションしなければ不正な値を返すことがある。
  #   例えば要素数が足りない、文字列が混ざっている、等
  # * 保守性が低い。
  #   例えば、要件追加等で除外される値を2つ見つけるよう改修する場合、等

  def self.find_by_subtraction(ary)
    validate_argument(ary)
    sum_of_1_to_10000 = 50005000
    ary.inject(sum_of_1_to_10000, :-)
  end

  # 引数一つ一つを全てそろっている数字の配列から消去し、最後に残った物が除外されていた値として得る方法
  # 計算量は O1(n/2) * O2(n/2)
  #  O1 ⇒ Eachの計算量、 O2 ⇒ Array#deleteの計算量
  # メモリ占有はFixnum 19999 個分(引数 + そろっている配列)
  # 除外値複数に対応できる様に改修する等も比較的容易にできますので、inject版より保守性に優れています。
  # 厳密に引数をバリデーションしなくても、多くの異常は最後に残った配列を検査すれば良いので、引数が信頼できない場合はメリットになります。
  # ただし、実測してみたところ、inject版と比較して3桁遅いです。
  # Array#deleteは破壊的メソッドなので、配列内のサーチ+削除した値より後ろの要素をシフトする処理があると推測されますが、
  # それがボトルネックになっている可能性があります。
  def self.find_by_deletion(ary)
    correct_nums = Array(1..10000)
    ary.each do |num|
      correct_nums.delete(num)
    end
    validate_result(correct_nums)
    correct_nums[0]
  end

  # 全てそろっている数字の配列より、順にArray#include?メソッドで探す方法
  # 計算量は O1(n/2) * O2(n)
  #  O1 ⇒ Eachの計算量、 O2 ⇒ Array#includeの計算量
  # メモリ占有はFixnum 19999 個分(引数 + そろっている配列)
  # 可読性は一番高いように思います。
  # 事前にバリデーションを詳細に行う必要があるのはinject版と同様です。
  def self.find_by_search(ary)
    validate_argument(ary)
    correct_nums = Array(1..10000)
    correct_nums.each do |num|
      return num unless ary.include?(num)
    end
  end

  def self.validate_argument(ary)
    raise OutOfRangeError.new if ary.size >= 10000
    # 以下、バリデーションの実装については、ディスカッションの観点とはあまり関係ないと思われるため省略します。
  end

  def self.validate_result(nums)
    raise IllegalArgumentError.new unless nums.size == 1
    # 以下、バリデーションの実装については、ディスカッションの観点とはあまり関係ないと思われるため省略します。
  end

  class OutOfRangeError < StandardError
  end

  class IllegalArgumentError < StandardError
  end

  # for command line invocation
  case ARGV[0]
    when '-b'
      p ExcludedNumFinder.find_by_subtraction(eval ARGV[1])
    when '-d'
      p ExcludedNumFinder.find_by_deletion(eval ARGV[1])
    when '-s'
      p ExcludedNumFinder.find_by_search(eval ARGV[1])
    else
      raise ArgumentError.new 'usage: excluded_num_finder.rb [-b | -d | -s] <array of nums>'
  end
end