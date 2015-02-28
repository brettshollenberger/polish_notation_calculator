class PolishCalculator
  attr_accessor :nodes

  def initialize(*args)
    @nodes = Node.new(*args)
  end

  def calculate
    nodes.reduce
  end
end
