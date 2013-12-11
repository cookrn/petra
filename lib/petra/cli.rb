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
        Generate,
        :project
    end
  end
end

require 'petra/cli/generate'
