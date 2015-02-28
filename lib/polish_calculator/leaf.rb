class PolishCalculator
  class Leaf
    attr_accessor :root

    def initialize(value)
      @root = value
    end

    def reducible?
      false
    end
  end
end
