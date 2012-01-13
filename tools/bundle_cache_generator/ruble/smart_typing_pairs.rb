module Ruble
  class SmartTypingPair
    def initialize(scope, path, pairs)
      @scope = scope
      @path = path
      @pairs = pairs
      @displayName = "smart_typing_pairs-" # FIXME Need to generate a guid!
    end

    def to_yaml_type
      "!!com.aptana.scripting.model.SmartTypingPairsElement"
    end
  end

  class SmartTypingPairsProxy
    def initialize(bundle, path)
      @bundle = bundle
      @path = path
    end

    def []=(scope, pairs)
      @bundle.add_children([SmartTypingPair.new(scope, @path, pairs)])
    end
  end

  def smart_typing_pairs
    SmartTypingPairsProxy.new($bundles.first, $bundles.first.path)
  end
end