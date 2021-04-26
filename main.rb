# frozen_string_literal: true

require 'docopt'
require 'json'

require './lib/spaces'

DOC = <<~DOCOPT
  Adds height and width dimensions to Factorio recipes.

  Usage:
    main --help | --version
    main [options] [path]

  Options:
    --pretty                      Display output as human readable
    --help                        Show this message.
    --version                     Print the version.
DOCOPT

args = begin
  Docopt.docopt DOC
rescue Docopt::Exit => e
  warn e.message
  exit(1)
end

if args['--version']
  puts Gem::Specification.load('spaces.gemspec').version
  exit(0)
end

file_contents = begin
  if args['path']
    File.read(args['path'])
  else
    $stdin.read
  end
rescue Errno::ENOENT => e
  warn 'File not found'
  warn e.message
  exit(2)
end

json = begin
  JSON.parse(file_contents)
rescue JSON::ParserError => e
  warn 'Could not parse input to a JSON'
  warn e.message
  exit(3)
end

Spaces.call(json)
      .yield_self do |hash|
        args['--pretty'] ? JSON.pretty_generate(hash) : JSON.generate(hash)
      end
      .tap { |result| puts result }
