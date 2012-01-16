require 'ruble/command'

module Ruble
  class ContentAssist < Command
    def to_yaml_type
      "!content_assist"
    end
  end

  def content_assist(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    ca = ContentAssist.new(name, path)
    yield ca
    $content_assists << ca
    ca
  end
end
