require 'pry'

class JackTokenizer
  KEYWORD = %w[class constructor function method field static var int char boolean void true false null this let do if else while return]
  SYMBOL = %w[{ } ( ) [ ] . , ; + - * / & | < > = -]

  class UnexpectedToken < StandardError; end

  attr_reader :lines
  attr_accessor :tokens
  
  def initialize(path)
    @lines = IO.readlines(path)
    @tokens = nil
  end

  def build_tokens(file_lines_array)
    tokens = []

    comments_removed_lines = remove_comments(file_lines_array)
    white_space_removed_lines = remove_crlf(comments_removed_lines)
    white_space_removed_lines.each do |line|
      tokens += convert_line_to_token_array(line)
    end

    tokens
  end

  def get_token_type(token)
    KEYWORD.include?(token) ? (return 'keyword') : nil
    SYMBOL.include?(token) ? (return 'symbol') : nil
    /^(?!\d)[A-z\d_]+/.match?(token) ? (return 'identifier') : nil
    /".+"/.match?(token) ? (return 'string_const') : nil
    (token >= 0 && token < 32768) ? (return 'int_const') : nil
    raise UnexpectedToken
  end

  private

  # remove three types of comments '//....', '/* .... */', '/** ..... */'
  def remove_comments(file_lines_array)
    reviewed_array = []

    file_lines_array.each do |line|
      return_line = line

      return_line.include?('//') ? return_line = return_line.gsub(/\/\/.*\r\n/, "\r\n") : nil
      return_line.include?('/*') ? return_line = return_line.gsub(/\/\*.*\*\//, '') : nil
      return_line.include?('/**') ? return_line = return_line.gsub(/\/\*\*.*\*\//, '') : nil
      reviewed_array.append(return_line)
    end
    
    reviewed_array
  end

  def remove_crlf(file_lines_array)
    reviewed_array = []

    file_lines_array.each do |line|
      processed_string = line.chomp
      processed_string.empty? ? nil : reviewed_array.append(processed_string)
    end
  end

  def convert_line_to_token_array(file_line)
    pattern = Regexp.union((SYMBOL))
    token_array = file_line.scan(/".+"|#{pattern}|[A-z0-9_]+/) 
  end

end
