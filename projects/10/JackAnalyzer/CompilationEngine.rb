require 'pry'

class CompilationEngine
  attr_accessor :tokens, :token_index, :indentation, :output

  class IncorrectPeakIndex < StandardError; end
  class IncorrectTokenIndex < StandardError; end
  class OutOfRangeLastToken < StandardError; end
  class UnexpectedToken < StandardError; end

  def initialize(token_file_path)
    @tokens = IO.readlines(token_file_path)
    @token_index = 0
    @indentation = 0
    @output = File.open("#{File.dirname(token_file_path)}/#{File.basename(token_file_path, ".*")[0..-2]}_tt.xml", 'w')
  end

  def compile_class
    eat('tokens', nil)
    @output.write("<class>")
    add_linebreak

    @indentation += 2
    eat('keyword', 'class')
    indent
    write_last_token
    add_linebreak
  end

  def peak(peak_index)
    target_index = @token_index + peak_index
    raise IncorrectPeakIndex if peak_index < 0
    raise IncorrectTokenIndex if target_index > (@tokens.size - 1)

    match_data = /<\/?([A-Za-z]+)>(?: (.+) <\/[A-Za-z]+>)?/.match(@tokens[target_index]).captures
    { type: match_data[0], value: match_data[1] }
  end

  def eat(type, value)
    current_token = peak(0)

    riase UnexpectedToken if type != current_token[:type] || value != current_token[:value]
    @token_index += 1

    current_token
  end

  def indent
    @output.write("#{" " * @indentation}")
  end

  def add_linebreak
    @output.write("\r\n")
  end

  def write_last_token
    raise OutOfRangeLastToken if @token_index == 0
    @output.write("#{@tokens[@token_index-1]}")
  end
end
