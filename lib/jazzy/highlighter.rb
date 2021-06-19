require 'rouge'

# While Rouge is downlevel (Rouge PR#1715 unmerged)
module Rouge
  module Lexers
    class Swift
      prepend :root do
        rule(/\b(?:async|await)\b/, Keyword)
        rule(/\b(?:actor|nonisolated)\b/, Keyword::Declaration)
      end
    end
  end
end

module Jazzy
  # This module helps highlight code
  module Highlighter
    SWIFT = 'swift'.freeze
    OBJC = 'objective_c'.freeze

    class Formatter < Rouge::Formatters::HTML
      def initialize(language)
        @language = language
        super()
      end

      def stream(tokens, &b)
        yield "<pre class=\"highlight #{@language}\"><code>"
        super
        yield "</code></pre>\n"
      end
    end

    def self.highlight_swift(source)
      highlight(source, SWIFT)
    end

    def self.highlight_objc(source)
      highlight(source, OBJC)
    end

    def self.highlight(source, language)
      source && Rouge.highlight(source, language, Formatter.new(language))
    end
  end
end
