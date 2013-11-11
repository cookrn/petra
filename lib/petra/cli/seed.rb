require 'petra/cli/subcommand'

module Petra
  class CLI
    Subcommand :Seed do
      attr_reader :seed_name

      command_description 'Manage & build seeds'
      command_invocation  'seed'
      command_usage       'seed <subcommand> <...args>'

      desc \
        'new <name>',
        'Create a new seed named <name>'

      def new( seed_name )
        @seed_name ||= seed_name
        template_new_seed!
      end

      no_commands do
        def template_new_seed!
          empty_directory 'seeds'

          directory \
            'seed/new',
            '.'
        end
      end
    end
  end
end
