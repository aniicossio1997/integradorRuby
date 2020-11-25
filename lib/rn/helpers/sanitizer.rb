module RN
  module Helpers
    class Sanitizer
      def self.string(object)
        ((object.strip).gsub(/\W|[[:space:]]/, '_')).downcase
      end
    end
 end
end