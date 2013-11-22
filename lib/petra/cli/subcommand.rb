require 'petra/patches/thor'

module Petra
  class CLI
    class Subcommand < Thor
      include Thor::Actions

      module ClassMethods
        %w(
          description
          invocation
          usage
        ).each do | attr |
          module_eval <<-___ , __FILE__ , __LINE__
            def command_#{ attr }( val = nil )
              if val
                @_command_#{ attr } ||= val
              end

              @_command_#{ attr }
            end
          ___
        end
      end

      def self.inherited( klass )
        klass.source_root "#{ LIBPATH }/sources"
        klass.extend ClassMethods
      end
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
