module Petra
  module Util
    class HashWithIndifferentAccess < Hash
      alias_method \
        :__get__,
        :[]

      def []( key )
        val = __get__ key

        unless val
          val =
            case key
            when String
              __get__ key.to_sym
            when Symbol
              __get__ key.to_s
            end
        end

        val
      end

      alias_method \
        :"__has_key__",
        :key?

      def key?( k )
        does_have = __has_key__ k

        unless does_have
          does_have =
            case k
            when String
              __has_key__ k.to_sym
            when Symbol
              __has_key__ k.to_s
            end
        end

        does_have
      end

      def method_missing( method , *args , &block )
        if name = is_setter?( method )
          val = args.first
          if key?( name )
            k = key self[ name ]
            self[ k ] = val
          else
            self[ name ] = val
          end
        elsif key?( method )
          self[ method ]
        else
          super
        end
      end

      def respond_to?( method , * )
        super or key?( method ) or !!is_setter?( method )
      end

      def respond_to_missing?( method , * )
        key?( method ) or !!is_setter?( method ) or super
      end

      def is_setter?( method )
        method =~ /=$/
        $`
      end
    end
  end
end
