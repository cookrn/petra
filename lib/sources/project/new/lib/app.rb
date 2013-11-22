require 'yaml'

module App
  extend self

  attr_accessor \
    :seeds,
    :machine_configs,
    :root

  class Hashy < Hash
    alias_method :__old_get__ , :[]

    def get( key )
      if has_key?( key )
        __old_get__ key
      else
        self[ key ] = self.class.new
      end
    end
    alias_method :[] , :get

    def register( key , &block )
      self[ key ] = block
    end
  end

  self.machine_configs = Hashy.new
  self.root = File.expand_path "#{ __FILE__ }/../.."

  def load_machines!( config )
    Dir[ "#{ root }/machines/**/**.vagrant.rb" ].each do | machine |
      load machine
    end

    machines =
      if ENV[ 'MACHINES' ]
        ENV[ 'MACHINES' ].split ','
      else
        machine_configs.keys
      end

    machines.each do | machine |
      if machine_config = machine_configs[ machine ]
        instance_exec config , &machine_config
      end
    end
  end
end
