require 'ruble/command'

module Ruble
  class Command
    def invoke(&block)
      # yield a proxy object that just eats calls
      InvokeProxy.new(self)
    end

    def invoke=(script)
      # no-op
    end
  end

  class InvokeProxy
    def initialize(command)
      @command = command
    end

    def all=(script)
      # no-op
    end

    def mac=(script)
      # no-op
    end

    def mac(&block)
      # no-op
    end

    def windows=(script)
      # no-op
    end

    def windows(&block)
      # no-op
    end

    def linux=(script)
      # no-op
    end

    def linux(&block)
      # no-op
    end

    def unix=(script)
      # no-op
    end

    def unix(&block)
      # no-op
    end
  end
end