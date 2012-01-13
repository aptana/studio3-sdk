module Ruble
  class Env
    def initialize(scope, path)
      @scope = scope
      @path = path
      @displayName = "environment-" # FIXME Need to generate some guid...
    end

    def []=(key, value)
      # no-op
    end

    def delete(key)
      # no-op
    end

    def include?(key)
      true
    end

    def to_yaml_type
      "!environment"
    end
  end
end

def env(scope, &block)
  path = $0
  path = block.binding.eval("__FILE__") if block
  e = Env.new(scope, path)
  yield e
  $envs << e
  e
end
