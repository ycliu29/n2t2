require 'pry'

class CompilationEngine
  attr_accessor :tokens, :token_index, :indentation

  class IncorrectTokenIndex < StandardError; end

  def initialize(token_file_path)
    @tokens = IO.readlines(token_file_path)
    @token_index = 0
    @indentation = 0
  end

  def peak(peak_index)
    target_index = @token_index + peak_index
    raise IncorrectTokenIndex if target_index > (@tokens.size - 1)

    match_data = /<\/?([A-Za-z]+)>(?: (.+) <\/[A-Za-z]+>)?/.match(@tokens[target_index]).captures
    { type: match_data[0], value: match_data[1] }
  end
end
