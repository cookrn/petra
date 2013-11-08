class Thor
  class Command
   def formatted_usage(klass, namespace = true, subcommand = false)
      if namespace
        namespace = klass.namespace
        formatted = "#{namespace.gsub(/^(default)/,'')}:"
      end
      formatted = "#{klass.namespace.split(':').last} " if subcommand

      formatted ||= ""

      # PATCH :: properly display subcommands
      #
      # Tasks/Commands registered in subcommands incorrectly
      # display at the top level with the default Thor help
      # task. This attempts to fix the issue.
      #
      # WARN :: it probably won't work for subcommands of subcommands
      #
      if !subcommand and klass.ancestors.include?( Petra::CLI::Subcommand )
        formatted << "#{ klass.command_invocation } "
      end

      # Add usage with required arguments
      formatted << if klass && !klass.arguments.empty?
        usage.to_s.gsub(/^#{name}/) do |match|
          match << " " << klass.arguments.map{ |a| a.usage }.compact.join(' ')
        end
      else
        usage.to_s
      end

      # Add required options
      formatted << " #{required_options}"

      # Strip and go!
      formatted.strip
    end
  end
end
