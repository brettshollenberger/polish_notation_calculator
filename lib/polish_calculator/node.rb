class PolishCalculator
  class Node
    attr_accessor :root, :left, :right

    def initialize(args)
      @root = args.pop

      %w(left right).each do |leaf|
        if is_operator?(args[-1])
          instance_variable_set("@#{leaf}", Node.new(args))
        else
          instance_variable_set("@#{leaf}", Leaf.new(args.pop.to_i))
        end
      end
    end

    def reduce
      l  = left.reducible?  ? left.reduce  : left.root
      r  = right.reducible? ? right.reduce : right.root
      op = root

      l.send(op, r)
    end

    def reducible?
      true
    end

  private
    def supported_operators
      %w(* + - /)
    end

    def is_operator?(arg)
      supported_operators.include?(arg)
    end
  end
end
