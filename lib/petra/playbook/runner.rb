require 'systemu'

module Petra
  class Playbook
    class Runner
      attr_reader :playbook

      def self.execute( *args , &block )
        new( *args , &block ).execute
      end

      def initialize( playbook )
        @playbook = playbook
      end

      def command
        "ansible-playbook #{ playbook_name }"
      end

      def execute
        systemu command
      end

      def playbook_name
        if playbook.name =~ /\.yml\z/i
          playbook.name
        else
          "#{ playbook.name }.yml"
        end
      end
    end
  end
end
