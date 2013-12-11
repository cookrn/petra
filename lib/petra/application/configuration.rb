module Petra
  class Application
    class Configuration < Util::HashWithIndifferentAccess
      def initialize( root )
        self[ :root ] ||= root
      end
    end
  end
end
