require_relative 'JackTokenizer.rb'

# TODO: accept file or folder
file_path = ARGV[0]

tokenizer = JackTokenizer.new(file_path)
tokenizer.lines
