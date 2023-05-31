require_relative 'JackTokenizer.rb'
require 'pry'

# TODO: accept file or folder
file_path = ARGV[0]

tokenizer = JackTokenizer.new(file_path)
tokenizer.tokens = tokenizer.build_tokens(tokenizer.lines) 
binding.pry
