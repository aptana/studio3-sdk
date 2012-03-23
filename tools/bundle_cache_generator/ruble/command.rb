module Ruble
  class Command
    def initialize(name, path)
      @displayName = name
      @path = path
      @runType = 'current_thread'
      @workingDirectoryType = 'UNDEFINED'
      @async = false
      @input = ['none']

      bundle = $bundles.last
      bundle.apply_defaults(self) unless bundle.nil?
    end

    def trigger=(trigger)
      @customProperties ||= {}
      @customProperties['prefix_values'] = [trigger].flatten
    end

    def output=(output_type)
      @outputType = output_type.to_s
    end

    def working_directory=(type)
      @workingDirectoryType = type.to_s.upcase
    end

    def input=(input)
      @input = [input].flatten.map {|w| w.to_s}
    end

    def scope=(scope)
      case scope
      when Array
        @scope = scope.map {|s| s.to_s }.join(", ")
      else
      @scope = scope.to_s
      end
    end

    def to_yaml_type
      "!command"
    end
  end

  def command(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    c = Command.new(name, path)
    yield c
    $commands ||= []
    $commands << c
    c
  end
end
