# frozen_string_literal: true
require('b')

module B
  module Commands
    class Help < B::Command
      def call(_args, _name)
        puts(CLI::UI.fmt('{{bold:Available commands}}'))
        puts('')

        B::Commands::Registry.resolved_commands.each do |name, klass|
          next if name == 'help'
          puts(CLI::UI.fmt("{{command:#{B::TOOL_NAME} #{name}}}"))
          if (help = klass.help)
            puts(CLI::UI.fmt(help))
          end
          puts('')
        end
      end
    end
  end
end
