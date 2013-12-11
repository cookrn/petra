require 'pathname'

# See: https://github.com/rails/rails/blob/17c29a0df0da5414570b025b642e90968e96cddc/railties/lib/rails/application.rb
# See: https://github.com/rails/rails/blob/17c29a0df0da5414570b025b642e90968e96cddc/railties/lib/rails/engine.rb

#   1)  require "config/boot.rb" to setup load paths
#   2)  TODO require railties and engines
#   3)  Define Petra.application as "class MyApp::Application < Petra::Application"
#   4)  TODO Run config.before_configuration callbacks
#   5)  TODO Load config/environments/ENV.rb
#   6)  TODO Run config.before_initialize callbacks
#   7)  TODO Run Railtie#initializer defined by railties, engines and application.
#       One by one, each engine sets up its load paths, routes and runs its config/initializers/* files.
#   8)  TODO Custom Railtie#initializers added by railties, engines and applications are executed
#   9)  TODO Build the middleware stack and run to_prepare callbacks
#   10) TODO Run config.before_eager_load and eager_load! if eager_load is true
#   11) TODO Run config.after_initialize callbacks

module Petra
  class Application
    DEFAULT_ROOT_FLAG = 'Vagrantfile'.freeze

    autoload \
      :Configuration,
      'petra/application/configuration'

    include Initializable

    class << self
      attr_accessor \
        :called_from,
        :root_flag

      private \
        :allocate,
        :new

      def inherited( child )
        call_stack = caller.map { | location | location.sub /:\d+.*/ , '' }

        child.called_from = Pathname.new( File.dirname call_stack.shift )
        child.root_flag ||= DEFAULT_ROOT_FLAG

        Petra.application = child.instance
      end

      def instance
        @instance ||= new
      end

      def method_missing( *args , &block )
        instance.send *args , &block
      end
    end

    def configuration
      @_configuration ||= Configuration.new find_root_with_flag( self.class.root_flag )
    end

    alias_method \
      :config,
      :configuration

    # See: https://github.com/rails/rails/blob/17c29a0df0da5414570b025b642e90968e96cddc/railties/lib/rails/engine.rb#L663-L675
    def find_root_with_flag( flag , default = nil )
      root_path = self.class.called_from

      while root_path and File.directory?( root_path ) && !File.exist?( "#{ root_path }/#{ flag }" )
        old_root_path = root_path.dup
        root_path     = File.dirname root_path
        old_root_path != root_path
      end

      root_path =
        if File.exist?( "#{ root_path }/#{ flag }" )
          root_path
        else
          default
        end

      raise "Could not find root path for #{ self.inspect }" unless root_path

      Pathname.new root_path
    end

    # See: https://github.com/rails/rails/blob/17c29a0df0da5414570b025b642e90968e96cddc/railties/lib/rails/application.rb#L253-L260
    def initialize!( group = :default )
      @initialized ||= false
      raise 'Application already initialized!' if @initialized

      run_initializers \
        group,
        self

      @initialized = true
      self
    end

    def initialized?
      !!@initialized
    end

    def initializer( *args , &block )
      self.class.initializer *args , &block
    end
  end
end
