require 'ruble/command'

$snippets ||= []

module Ruble
  class Snippet < Command
    attr_accessor :expansion

    def initialize(name, path)
      super
      output = 'insert_as_snippet'
    end

    def to_yaml_type
      '!!com.aptana.scripting.model.SnippetElement'
    end
  end

  def snippet(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    s = Snippet.new(name, path)
    yield s
    $snippets << s
    s
  end
end
