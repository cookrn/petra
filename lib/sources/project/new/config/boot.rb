# somehow find and load petra or abort

require 'vagrant' unless defined? Vagrant

unless defined? Petra
  Module.new do
    petra_is_loaded =
      [
        lambda { true },

        lambda {
          ENV[ 'BUNDLE_GEMFILE' ] ||=
            File.expand_path \
              '../../Gemfile',
              __FILE__

          require 'bundler/setup' if File.exists?( ENV[ 'BUNDLE_GEMFILE' ] )
        },

        lambda {
          symlinked_vendor_path =
            File.expand_path \
              '../../vendor/petra-development-link/lib',
              __FILE__

          if Dir.exists?( symlinked_vendor_path )
            $LOAD_PATH.unshift symlinked_vendor_path
          end
        }
      ].detect do | loader |
        begin
          loader.call and Vagrant.require_plugin( 'petra' )
        rescue Object => e
          false
        end
      end

    raise LoadError unless petra_is_loaded && defined?( Petra )
  end
end
