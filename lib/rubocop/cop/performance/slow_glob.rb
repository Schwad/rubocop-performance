# frozen_string_literal: true

module RuboCop
  module Cop
    module Performance
      #
      # `**` is orders of magnitude slower than `{*,*/*}` in large directories
      #
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   Dir["some/**/path"]
      #
      #   # good
      #   Dir["some/{*,*/*}/path"]
      #

      class SlowGlob < Base
        extend AutoCorrector
        include RangeHelp

        MSG = 'Use `{*,*/*}` instead of `**`.'

        RESTRICT_ON_SEND = %i[uses_slow_glob?].freeze

        def_node_matcher :uses_slow_glob?, <<~PATTERN
          (block
            (send
              (send
                (const nil? :Dir ...) :[]
                $(str /\\*\\*/)
                ...)
              ...)
            ...)
        PATTERN

        def on_block(node)
          expression = uses_slow_glob?(node)
          return unless expression

          add_offense(node.children[0].children[0].children[-1])
          # # Todo autocorrect
          # add_offense(node) do |corrector|
          #   corrector.replace(node, "#{expression.source}.any?")
          # end
        end
      end
    end
  end
end
