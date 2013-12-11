module Petra
  ROOTPATH =
    File.expand_path \
      '../..',
      __FILE__

  LIBPATH = "#{ ROOTPATH }/lib"

  class << self
    attr_accessor :application

    def root
      application.configuration.root
    rescue => e
      nil
    end
  end

  autoload \
    :Application,
    'petra/application'

  autoload \
    :Initializable,
    'petra/initializable'

  autoload \
    :Util,
    'petra/util'

  autoload \
    :VERSION,
    'petra/version'
end
