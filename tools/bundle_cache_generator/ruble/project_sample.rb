module Ruble
  class ProjectSample
    attr_writer :location, :description, :id, :category, :natures, :icon

    def initialize(name, path)
      @displayName = name
      @id = name
      @path = path
    end

    def to_yaml_type
      '!!com.aptana.scripting.model.ProjectSampleElement'
    end
  end

  def project_sample(name, &block)
    path = $0
    path = block.binding.eval("__FILE__") if block
    t = ProjectSample.new(name, path)
    yield t
    $project_samples << t
    t
  end
end