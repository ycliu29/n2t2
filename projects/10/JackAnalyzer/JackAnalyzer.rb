require_relative 'JackTokenizer.rb'

# TODO: accept file or folder
file_path = ARGV[0]

tokenizer = JackTokenizer.new()
tokenizer.lines
