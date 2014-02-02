require 'petra/playbook'

module Petra
  ROOTPATH =
    File.expand_path \
      '../..',
      __FILE__

  LIBPATH = "#{ ROOTPATH }/lib"

  def self.playbook( *args , &block )
    Playbook.new *args , &block
  end
end
