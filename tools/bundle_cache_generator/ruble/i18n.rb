# we intercept calls to translate, record the key, and return it.
# Later on we replace the keys with locale-specific values per localized cache file.
module Ruble
  class MissingInterpolationArgument < ArgumentError
    attr_reader :values, :string
    def initialize(values, string)
      @values, @string = values, string
      super "missing interpolation argument in #{string.inspect} (#{values.inspect} given)"
    end
  end

  # We use special sigils to mark things needing to be translated, and generate a fully unique named based on
  # the translation key plus the hash of the interpolation variables 9so the same key with different variables
  # becomes different). We look for these special sigils to replace with translated values and split the original
  # translation key from the interpolation hashcode.
  def t(translation_key, variables = {})
    $translations ||= {}
    key = "@##{translation_key.to_s};>#{variables.object_id.to_s}@#"
    $translations[key] = variables
    key
  end

  INTERPOLATION_PATTERN = Regexp.union(
    /%%/,
    /%\{(\w+)\}/,                               # matches placeholders like "%{foo}"
    /%<(\w+)>(.*?\d*\.?\d*[bBdiouxXeEfgGcps])/  # matches placeholders like "%<foo>.d"
  )

  def Ruble.interpolate(string, values)
    string.gsub(INTERPOLATION_PATTERN) do |match|
      if match == '%%'
        '%'
      else
        key = ($1 || $2).to_sym
        value = values.key?(key) ? values[key] : raise(MissingInterpolationArgument.new(values, string))
        value = value.call(values) if value.respond_to?(:call)
        $3 ? sprintf("%#{$3}", value) : value
      end
    end
  end
end