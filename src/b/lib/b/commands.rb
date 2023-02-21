# frozen_string_literal: true
require('b')

module B
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(
      default: 'help',
      contextual_resolver: nil
    )

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register(:Help, 'help', 'b/commands/help')
    register(:Up,   'up',   'b/commands/up')
  end
end
