require 'pry'

class CompilationEngline
  attr_accessor :tokens

  @@token_index = 0

  class IncorrectTokenIndex < StandardError; end

  def initialize(token_file_path)
    @tokens = IO.readlines(token_file_path)
  end

  def current_token
    raise IncorrectTokenIndex if @@token_index > (@tokens.size - 1)



    # { type: , value: }
  end
end
