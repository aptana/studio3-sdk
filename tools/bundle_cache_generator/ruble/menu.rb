module Ruble
  class Menu
    attr_writer :commandName
    def initialize(name, path)
      @displayName = name
      @path = path

      bundle = $bundles.last
      bundle.apply_defaults(self) unless bundle.nil?
    end

    def command(name)
      child_menu = Menu.new(name, @path)
      child_menu.commandName = name
      @children ||= []
      @children << child_menu
    end

    def separator
      command('-')
    end

    def menu(name, &block)
      m = Menu.new(name, @path)
      yield m
      @children ||= []
      @children << m
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
      '!!com.aptana.scripting.model.MenuElement'
    end
  end
end