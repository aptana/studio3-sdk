module Ruble
  class ProjectTemplate
    attr_writer :location, :description, :id, :icon, :tags

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

  def project_template(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    t = ProjectTemplate.new(name, path)
    yield t
    $project_templates << t
    t
  end
end
