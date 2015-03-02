class ExcludedNumFinder

  SUM_OF_1_TO_10000 = 50005000
  def self.find_by_subtraction(ary)
    ary.inject(SUM_OF_1_TO_10000, :-)
  end

end