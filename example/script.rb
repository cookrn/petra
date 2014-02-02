#!/usr/bin/env ruby

begin
  require 'petra'
rescue LoadError => e
  gemfile_path =
    File.expand_path \
      '../../Gemfile',
      __FILE__

  if File.exists? gemfile_path
    ENV[ 'BUNDLE_GEMFILE' ] ||= gemfile_path
    require 'bundler/setup'
    retry
  else
    raise e
  end
end

status , stdout , stderr =
  Dir.chdir File.dirname( __FILE__ ) do
    playbook = Petra.playbook :playbook
    playbook.run
  end

puts "STATUS: #{ status }"
puts

stdout =
  if stdout.chomp.empty?
    '<empty>'
  else
    "\n#{ stdout }"
  end

puts '=-=-=-=-=-=-=-=-=-=-=-='
puts "STDOUT: #{ stdout }"
puts '=-=-=-=-=-=-=-=-=-=-=-='

stderr =
  if stderr.chomp.empty?
    '<empty>'
  else
    "\n#{ stderr }"
  end

puts '=-=-=-=-=-=-=-=-=-=-=-='
puts "STDERR: #{ stderr }"
puts '=-=-=-=-=-=-=-=-=-=-=-='

exit 0
