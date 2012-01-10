$bundles = []
$commands = []
$snippets = []
$envs = []
$templates = []
$project_templates = []
$content_assists = []
$translations = []

module Ruble
  def self.is_mac?
    true
  end
  
  def self.is_windows?
    true
  end

  class FoldingProxy
    def initialize(bundle)
      @bundle = bundle
    end
    
    def []=(scope, array)
      map = {}
      map[scope.to_s.gsub(/_/, '.')] = array.first
      @bundle.foldingStartMarkers = map
      
      decrease_map = {}
      decrease_map[scope.to_s.gsub(/_/, '.')] = array.last
      @bundle.foldingStopMarkers = decrease_map
    end
  end
  
  class IndentProxy
    def initialize(bundle)
      @bundle = bundle
    end
    
    def []=(scope, array)
      map = {}
      map[scope.to_s.gsub(/_/, '.')] = array.first
      @bundle.increaseIndentMarkers = map
      
      decrease_map = {}
      decrease_map[scope.to_s.gsub(/_/, '.')] = array.last
      @bundle.decreaseIndentMarkers = decrease_map
    end
  end
  
  class FileTypesProxy
    def initialize(bundle)
      @bundle = bundle
    end
    
    def []=(scope, array)
      map = {}
      mod_scope = scope.to_s.gsub(/_/, '.')
      array = [array].flatten
      array.each {|name| map[name] = mod_scope }
      @bundle.fileTypes = array
      @bundle.fileTypeRegistry = map
    end
  end
  
  class BuildPathElement
    def initialize(name, path, location)
      @displayName = name
      @path = path
      @buildPath = location
    end
    
    def to_yaml_type
      '!!com.aptana.scripting.model.BuildPathElement'
    end
  end
  
  class BuildPathProxy
    def initialize(bundle)
      @bundle = bundle
    end
    
    def []=(name, location)
      @bundle.add_children([BuildPathElement.new(name, @bundle.path, location)])
    end
  end
  
  class Bundle
    @@defaults = {}
    attr_writer :author, :copyright, :description, :repository, :license, :licenseUrl
    attr_reader :path
    
    def initialize(name, path)
      @displayName = name
      @path = path
      @children = []
      @visible = true
    end

    def display_name=(name)
      @displayName = name
    end

    def menu(name, &block)
      path = $0
      path = block.binding.eval("__FILE__") if block
      m = Menu.new(name, path)
      yield m
      @children << m
    end
    
    def folding
      FoldingProxy.new(self)
    end
    
    def foldingStartMarkers=(map)
      @foldingStartMarkers = map
    end
    
    def foldingStopMarkers=(map)
      @foldingStopMarkers = map
    end
    
    def indent
      IndentProxy.new(self)
    end
    
    def increaseIndentMarkers=(map)
      @increaseIndentMarkers = map
    end
    
    def decreaseIndentMarkers=(map)
      @decreaseIndentMarkers = map
    end
    
    def file_types
      FileTypesProxy.new(self)
    end
    
    def fileTypes(array)
      @fileTypes = array
    end
    
    def fileTypeRegistry(map)
      @fileTypeRegistry = map
    end
    
    def project_build_path
      BuildPathProxy.new(self)
    end
    
    def add_children(children)
      children.each {|c| @children << c }
    end
    
    def pop_defaults
      value_hashes = @@defaults[@path.to_sym]

      value_hashes.pop if !value_hashes.nil?
    end

    def push_defaults(defaults)
      value_hashes = @@defaults[@path.to_sym]

      if value_hashes.nil?
        @@defaults[@path.to_sym] = [defaults]
      else
        value_hashes.push((value_hashes.length == 0) ? defaults : value_hashes[-1].merge(defaults))
      end
    end
    
    def to_yaml_type
      '!!com.aptana.scripting.model.BundleElement'
    end
    
    def method_missing(m, *args, &block)
      @customProperties ||= {}
      property_name = m.to_s
      
      if property_name.end_with?("=")
        @customProperties[property_name.chop] = args[0]
      else
        @customProperties[property_name]
      end
    end
  end
  
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
  
  class Menu
    attr_writer :commandName
    
    def initialize(name, path)
      @displayName = name
      @path = path
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
    
    def initialize(name, path)
      @displayName = name
      @path = path
      @runType = 'current_thread'
      @workingDirectoryType = 'UNDEFINED'
      @async = false
      @input = ['none']
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

    def invoke(&block)
      # no-op FIXME yield a context object that just eats calls? Is that even necessary?
      InvokeProxy.new(self)
    end
    
    def invoke=(script)
      # no-op
    end

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
    
    def to_yaml_type
      "!command"
    end
  end
  
  class Platform
    def initialize(name)
      @name = name
    end
    
    def to_yaml_type
      "!!com.aptana.scripting.model.Platform"
    end
    
    def to_yaml(opts = {})
      YAML.quick_emit( nil, opts ) { |out| out.scalar( taguri, @name, :plain ) }
    end
  end
  
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
  
  class ProjectTemplate
    attr_writer :location, :description, :id

    def initialize(name, path)
      @displayName = name
      @id = name
      @path = path
    end
    
    def type=(type)
      @type = type.to_s.upcase
    end
    
    def replace_parameters=(params)
      @customProperties ||= {}
      @customProperties['replace_parameters'] = params
    end
    
    def to_yaml_type
      '!!com.aptana.scripting.model.ProjectTemplateElement'
    end
  end
  
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
  
  class ContentAssist < Command
    def to_yaml_type
      "!content_assist"
    end
  end

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
  
  # top-level helper methods
  def bundle(name = "", &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    b = Bundle.new(name, path)
    yield b
    $bundles << b
    b
  end

  def command(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    c = Command.new(name, path)
    yield c
    $commands << c
    c
  end
  
  def env(scope, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    e = Env.new(scope, path)
    yield e
    $envs << e
    e
  end
  
  def smart_typing_pairs
    SmartTypingPairsProxy.new($bundles.first, $bundles.first.path)
  end

  def snippet(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    s = Snippet.new(name, path)
    yield s
    $snippets << s
    s
  end
  
  def template(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    t = Template.new(name, path)
    yield t
    $templates << t
    t
  end
  
  def project_template(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    t = ProjectTemplate.new(name, path)
    yield t
    $project_templates << t
    t
  end
  
  def content_assist(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    ca = ContentAssist.new(name, path)
    yield ca
    $content_assists << ca
    ca
  end
  
  def t(translation_key, variables = {})
    # TODO Store the key and variables so we can later replace values?
    $translations << translation_key
    translation_key.to_s
  end
  
  def with_defaults(values, &block)
    bundle = $bundles.last
    bundle.push_defaults values
    block.call(bundle) if block_given?
    bundle.pop_defaults
  end
end