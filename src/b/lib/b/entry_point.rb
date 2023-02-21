# frozen_string_literal: true
require('b')

module B
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = B::Resolver.call(args)
      B::Executor.call(cmd, command_name, args)
    end
  end
end
