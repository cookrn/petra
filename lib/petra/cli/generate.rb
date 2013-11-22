module Petra
  class CLI
    Subcommand :Generate do
      attr_reader \
        :machine_name,
        :playbook_name,
        :project_name,
        :seed_name

      command_description 'Template various parts of, or whole, Petra projects'
      command_invocation  'generate'
      command_usage       'generate <subcommand> <...args>'

      desc \
        'machine <name>',
        'Create a new machine named <name>'

      def machine( machine_name )
        @machine_name ||= machine_name

        template_new_machine!

        invoke_new_seed!
        invoke_new_playbook!
      end

      desc \
        'playbook <name>',
        'Create a new playbook named <name>'

      def playbook( playbook_name )
        @playbook_name ||= playbook_name
        template_new_playbook!
      end

      desc \
        'project <name>',
        'Create a new Petra project named <name>'

      option \
        :machine_name,
        :aliases  => '-m',
        :default  => 'default',
        :desc     => 'The name of the first machine in the project.'

      def project( project_name )
        @project_name ||= project_name

        template_new_project_directory!

        inside project_name do
          invoke_new_machine!
        end
      end

      desc \
        'seed <name>',
        'Create a new seed named <name>'

      def seed( seed_name )
        @seed_name ||= seed_name
        template_new_seed!
      end

      no_commands do
        def invoke_new_playbook!
          invoke \
            Generate,
            :playbook,
            [ machine_name ]
        end

        def invoke_new_seed!
          invoke \
            Generate,
            :seed,
            [ machine_name ]
        end

        def invoke_new_machine!
          invoke \
            Generate,
            :machine,
            [ machine_name ],
            Hash.new
        end

        def machine_name
          @machine_name or options.machine_name
        end

        def petra_version
          Petra::VERSION
        end

        def template_new_machine!
          empty_directory 'machines'

          directory \
            'machine/new',
            '.'
        end

        def template_new_playbook!
          directory \
            'playbook/new',
            '.'
        end

        def template_new_project_directory!
          directory \
            'project/new',
            project_name
        end

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
