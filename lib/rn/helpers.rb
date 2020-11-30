module RN
  module Helpers
    autoload :Sanitizer, 'rn/helpers/sanitizer'
    autoload :Enum, 'rn/helpers/enum'
    def sanitizer_string(string)
      ((string.strip).gsub(/\W|[[:space:]]/, '_')).downcase
    end
  end
end
