# Add methods to hash for use in this file...
class Hash
  def deep_merge!(other_hash)
    replace(deep_merge(other_hash))
  end

  def deep_merge(other_hash)
    self.merge(other_hash) do |key, oldval, newval|
      oldval = oldval.to_hash if oldval.respond_to?(:to_hash)
      newval = newval.to_hash if newval.respond_to?(:to_hash)
      oldval.class.to_s == 'Hash' && newval.class.to_s == 'Hash' ? oldval.deep_merge(newval) : newval
    end
  end
end

# This script is expected to be passed a ruble root dir as an argument. It
# then generates localized cache YML files for that ruble.
if __FILE__ == $0
  $: << File.dirname(__FILE__)
  require 'ruble'
  include Ruble

  require 'yaml'

  # We got run. We need to load up the ruble against this fake API and then spit out
  # the locale specific caches!
  bundle_dir = ARGV.shift
  bundle_files = []

  # check for a top-level bundle.rb file
  bundle_file = File.join(bundle_dir, "bundle.rb")
  bundle_files << bundle_file if File.exist?(bundle_file)

  # check for scripts inside "commands" directory
  commands_dir = File.join(bundle_dir, "commands")
  if File.exist?(commands_dir)
    Dir.new(commands_dir).each {|file| bundle_files << File.join(commands_dir, file) if file.end_with? '.rb' }
  end

  # check for scripts inside "snippets" directory
  snippets_dir = File.join(bundle_dir, "snippets")
  if File.exist?(snippets_dir)
    Dir.new(snippets_dir).each {|file| bundle_files << File.join(snippets_dir, file) if file.end_with? '.rb' }
  end

  # look for templates inside "templates" directory
  templates_dir = File.join(bundle_dir, "templates")
  if File.exist?(templates_dir)
    Dir.new(templates_dir).each {|file| bundle_files << File.join(templates_dir, file) if file.end_with? '.rb' }
  end

  # look for samples inside "samples" directory
  samples_dir = File.join(bundle_dir, "samples")
  if File.exist?(samples_dir)
    Dir.new(samples_dir).each {|file| bundle_files << File.join(samples_dir, file) if file.end_with? '.rb' }
  end

  # Ok we've gathered up all the files we need to load...
  $: << File.join(bundle_dir, "lib")
  bundle_files.each {|file| load file }
  bundle = $bundles.first
  bundle.add_children($commands)
  bundle.add_children($snippets)
  bundle.add_children($envs)
  bundle.add_children($templates)
  bundle.add_children($project_templates)
  bundle.add_children($project_samples)
  bundle.add_children($content_assists)

  # Bundle has been loaded. Now we need to spit out cache files. Dump to YAML string
  serialized = YAML::dump($bundles.first)

  # do some regexp replacements for the class/tag names!
  serialized.gsub!('!ruby/regexp', '!regexp')

  # Make the paths relative to bundle_dir
  serialized.gsub!("path: #{bundle_dir}/", 'path: ')
  serialized.gsub!("bundlePath: #{bundle_dir}/", 'bundlePath: ')
  # Fix busted output for ` in smart typing pairs
  serialized.gsub!("- `", '- "`"')

  # Load up the available translations and inject them into the YAML for displayName and commandName properties
  translations = {}
  locale_files = []
  locales_dir = File.join(bundle_dir, "config", 'locales')
  if File.exist?(locales_dir)
    Dir.new(locales_dir).each {|file| locale_files << File.join(locales_dir, file) if file.end_with? '.yml' }
  end

  if locale_files.empty?
    # Just spit out a run of the mill cache file without language specified (probably en_US)
    File.open(File.join(bundle_dir, "cache.yml"), 'w') {|f| f.write(serialized) }
  else
    # Load up all translations into one hash
    locale_files.each do |locale_file|
      data = YAML.load_file(locale_file)
      data.each do |locale, d|
      translations[locale] ||= {}
        translations[locale].deep_merge!(d)
      end
    end
    # Now go through and export out the translated cache files
    translations.each do |locale, d|
      # Replace the display names with the translated strings
      localized_yaml = serialized.gsub(/^(\s*)(display|command)Name: ['"]?(\S+?)['"]?$/) do |match|
        # First try current locale, then en_US, then en, then use key as string
        translated = d[$3]
        translated = translations['en_US'][$3] if !translated && translations['en_US']
        translated = translations['en'][$3] if !translated && translations['en']
        translated = $3 if !translated
        "#{$1}#{$2}Name: #{translated.inspect}"
      end
      File.open(File.join(bundle_dir, "cache.#{locale}.yml"), 'w') {|f| f.write(localized_yaml) }
    end
  end
end