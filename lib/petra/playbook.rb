require 'petra/playbook/runner'

module Petra
  class Playbook
    attr_reader :name

    def initialize( name )
      @name = name
    end

    def run
      Runner.execute self
    end
  end
end
