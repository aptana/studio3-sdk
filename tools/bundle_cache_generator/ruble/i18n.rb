# we intercept calls to translate, record the key, and return it.
# Later on we replace the keys wil locale-specific values per localized cache file.
module Ruble
  def t(translation_key, variables = {})
    $translations ||= []
    $translations << translation_key
    translation_key.to_s
  end
end