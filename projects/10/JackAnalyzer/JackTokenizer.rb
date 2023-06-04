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

  def self.build_tokens(file_lines_array)
    tokens = []

    comments_removed_lines = remove_comments(file_lines_array)
    white_space_removed_lines = remove_crlf(comments_removed_lines)
    white_space_removed_lines.each do |line|
      tokens += convert_line_to_token_array(line)
    end

    tokens
  end

  def self.convert_token_to_xml(token)
    token_type = get_token_type(token)
    output = ''

    case token_type
    when 'keyword' then output = JackTokenizer.get_keyword(token)
    when 'symbol' then output = JackTokenizer.get_symbol(token)
    when 'identifier' then output = JackTokenizer.get_identifier(token)
    when 'string_const' then output = JackTokenizer.get_stringval(token)
    when 'int_const' then output = JackTokenizer.get_intval(token)
    end

    output
  end

  def self.get_token_type(token)
    KEYWORD.include?(token) ? (return 'keyword') : nil
    SYMBOL.include?(token) ? (return 'symbol') : nil
    /^(?!\d)[A-z\d_]+/.match?(token) ? (return 'identifier') : nil
    /".+"/.match?(token) ? (return 'string_const') : nil
    ((token.to_i == (Integer(token) rescue nil)) && token.to_i >= 0 && token.to_i < 32768) ? (return 'int_const') : nil
    raise UnexpectedToken
  end

  def self.get_keyword(token)
    "<keyword> #{token} </keyword>"
  end

  def self.get_symbol(token)
    output = token.dup

    case output
    when '<' then output = '&lt;'
    when '>' then output = '&gt;'
    when '&' then output = '&amp;'
    end

    "<symbol> #{output} </symbol>"
  end

  def self.get_identifier(token)
    "<identifier> #{token} </identifier>"
  end

  def self.get_intval(token)
    "<integerConstant> #{token} </integerConstant>"
  end

  def self.get_stringval(token)
    "<stringConstant> #{token[1..-2]}  </stringConstant>"
  end

  # remove three types of comments '//....', '/* .... */', '/** ..... */'
  def self.remove_comments(file_lines_array)
    reviewed_array = []

    file_lines_array.each do |line|
      return_line = line

      # 處理結尾所有 newline 的可能 情境
      return_line.include?('//') ? return_line = return_line.gsub(/\/\/.*(\r\n|\r|\n)/, "\r\n") : nil
      return_line.include?('/*') ? return_line = return_line.gsub(/\/\*.*\*\//, '') : nil
      return_line.include?('/**') ? return_line = return_line.gsub(/\/\*\*.*\*\//, '') : nil
      reviewed_array.append(return_line)
    end

    reviewed_array
  end

  def self.remove_crlf(file_lines_array)
    reviewed_array = []

    file_lines_array.each do |line|
      processed_string = line.chomp
      processed_string.empty? ? nil : reviewed_array.append(processed_string)
    end
  end

  def self.convert_line_to_token_array(file_line)
    pattern = Regexp.union(SYMBOL)
    token_array = file_line.scan(/".+"|#{pattern}|[a-zA-Z0-9_]+/)
  end

end
