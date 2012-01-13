module Ruble
  class KeyBindingProxy
    def initialize(command)
      @command = command
    end

    def all=(key_binding)
      @command.setKeyBinding('ALL', key_binding)
    end

    def mac=(key_binding)
      @command.setKeyBinding('MAC', key_binding)
    end

    def windows=(key_binding)
      @command.setKeyBinding('WINDOWS', key_binding)
    end

    def linux=(key_binding)
      @command.setKeyBinding('LINUX', key_binding)
    end

    def unix=(key_binding)
      @command.setKeyBinding('UNIX', key_binding)
    end
  end

  class Command
    def key_binding
      KeyBindingProxy.new(self)
    end

    def key_binding=(binding)
      setKeyBinding('ALL', binding)
    end
    
    def setKeyBinding(platform, binding)
      @keyBindingMap ||= {}
      @keyBindingMap[Platform.new(platform)] = [binding].flatten
    end
  end
end