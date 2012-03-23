module Ruble
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

    def defaults
      value_hashes = @@defaults[path.to_sym]

      (value_hashes.nil? || value_hashes.length == 0) ? {} : value_hashes[-1]
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

    def apply_defaults(obj)
      if obj.nil? == false
        defaults.each do |k,v|
          property = "#{k.to_s}=".to_sym

          if obj.respond_to?(property)
            obj.send(property, v)
          end
        end
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

  def bundle(name = "", &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    b = Bundle.new(name, path)
    yield b
    $bundles ||= []
    $bundles << b
    b
  end

  def with_defaults(values, &block)
    bundle = $bundles.last
    bundle.push_defaults values
    block.call(bundle) if block_given?
    bundle.pop_defaults
  end
end
