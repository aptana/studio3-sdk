require 'ruble/command'

module Ruble
  class Template < Command
    attr_writer :filetype
    
    def initialize(name, path)
      super
      output = :discard
    end

    def location=(location)
      # no-op
    end

    def to_yaml_type
      "!template"
    end
  end

  def template(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    t = Template.new(name, path)
    yield t
    $templates << t
    t
  end
end