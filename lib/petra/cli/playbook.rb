require 'petra/cli/subcommand'

module Petra
  class CLI
    Subcommand :Playbook do
      attr_reader :playbook_name

      command_description 'Manage & run playbooks'
      command_invocation  'playbook'
      command_usage       'playbook <subcommand> <...args>'

      desc \
        'new <name>',
        'Create a new playbook named <name>'

      def new( playbook_name )
        @playbook_name ||= playbook_name
        template_new_playbook!
      end

      no_commands do
        def template_new_playbook!
          directory \
            'playbook/new',
            '.'
        end
      end
    end
  end
end
