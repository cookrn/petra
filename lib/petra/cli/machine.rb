module Petra
  class CLI
    Subcommand :Machine do
      attr_reader :machine_name

      command_description 'Manage & build machines'
      command_invocation  'machine'
      command_usage       'machine <subcommand> <...args>'

      desc \
        'new <name>',
        'Create a new machine named <name>'

      def new( machine_name )
        @machine_name ||= machine_name

        template_new_machine!

        invoke_new_seed!
        invoke_new_playbook!
      end

      no_commands do
        def invoke_new_playbook!
          invoke \
            Playbook,
            :new,
            [ machine_name ]
        end

        def invoke_new_seed!
          invoke \
            Seed,
            :new,
            [ machine_name ]
        end

        def template_new_machine!
          empty_directory 'machines'

          directory \
            'machine/new',
            '.'
        end
      end
    end
  end
end
