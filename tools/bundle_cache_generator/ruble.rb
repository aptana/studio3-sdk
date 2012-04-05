# Fake ruble API. We implement bare bones model and just hold onto values.
# Then we use it to output YAML caches
$bundles ||= []
$commands ||= []
$snippets ||= []
$envs ||= []
$templates ||= []
$project_templates ||= []
$project_samples ||= []
$content_assists ||= []
$translations ||= {}

# Load all the files underneath 'ruble' subdir
ruble_dir = File.join(File.dirname(__FILE__), 'ruble')
Dir.chdir(ruble_dir) do
  Dir.glob("*.rb") do |file|
    require "ruble/#{file}"
  end
end
