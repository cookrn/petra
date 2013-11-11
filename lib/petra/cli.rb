require 'petra'
require 'thor'

module Petra
  class CLI < Thor
    desc \
      'new <name>',
      'Shortcut to create a new Petra project named <name>'

    option \
      :machine_name,
      :aliases  => '-m',
      :default  => 'default',
      :desc     => 'The name of the first machine in the project.'

    def new( project_name )
      invoke \
        Project,
        :new
    end
  end
end

require 'petra/cli/subcommand'

require 'petra/cli/machine'
require 'petra/cli/playbook'
require 'petra/cli/project'
require 'petra/cli/seed'
