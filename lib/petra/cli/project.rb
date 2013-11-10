require 'petra/cli/subcommand'

module Petra
  class CLI
    Subcommand :Project do
      attr_reader :project_name

      include Thor::Actions
      source_root "#{ LIBPATH }/sources"

      command_description 'Manage & build projects'
      command_invocation  'project'
      command_usage       'project <subcommand> <...args>'

      desc \
        'new <name>',
        'Create a new Ansible project named <name>'

      method_option \
        :machine_name,
        :aliases  => '-m',
        :default  => 'default',
        :required => false

      def new( project_name )
        @project_name ||= project_name

        directory \
          'ansible_project',
          project_name
      end

      no_commands do
        def machine_name
          options.machine_name
        end

        def petra_version
          Petra::VERSION
        end
      end
    end
  end
end
