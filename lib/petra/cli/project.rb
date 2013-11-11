module Petra
  class CLI
    Subcommand :Project do
      attr_reader :project_name

      command_description 'Manage & build projects'
      command_invocation  'project'
      command_usage       'project <subcommand> <...args>'

      desc \
        'new <name>',
        'Create a new Petra project named <name>'

      option \
        :machine_name,
        :aliases  => '-m',
        :default  => 'default',
        :desc     => 'The name of the first machine in the project.'

      def new( project_name )
        @project_name ||= project_name

        template_new_project_directory!

        inside project_name do
          invoke_new_machine!
        end
      end

      no_commands do
        def invoke_new_machine!
          invoke \
            Machine,
            :new,
            [ machine_name ],
            Hash.new
        end

        def machine_name
          options.machine_name
        end

        def petra_version
          Petra::VERSION
        end

        def template_new_project_directory!
          directory \
            'project/new',
            project_name
        end
      end
    end
  end
end
