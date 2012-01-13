module Ruble
  def self.is_mac?
    true
  end

  def self.is_windows?
    true
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
end