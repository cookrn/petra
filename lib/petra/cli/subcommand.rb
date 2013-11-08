require 'fattr'
require 'petra/patches/thor'

module Petra
  class CLI
    class Subcommand < Thor
      Fattr :command_description
      Fattr :command_invocation
      Fattr :command_usage
    end

    private

    def self.Subcommand( command_name , &block )
      subcommand_class =
        Class.new \
          Subcommand,
          &block

      const_set \
        command_name,
        subcommand_class

      register \
        subcommand_class,
        subcommand_class.command_invocation,
        subcommand_class.command_usage,
        subcommand_class.command_description

      subcommand_class
    end
  end
end
