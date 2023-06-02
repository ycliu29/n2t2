require_relative 'JackTokenizer.rb'
require 'pry'

def main()
  input_path = ARGV[0]

  if File.file?(input_path)
    file_name = File.basename(input_path, ".*")
    dir = File.dirname(input_path)
    xml_file = File.open("#{dir}/#{file_name}_test.xml", 'w')

    tokenizer = JackTokenizer.new(input_path)
    tokenizer.tokens = JackTokenizer.build_tokens(tokenizer.lines) 

    xml_file.write("<tokens>\r\n")
    tokenizer.tokens.each do |token|
      # TODO: encapsulate these logics into tokenizer
      token_type = JackTokenizer.get_token_type(token)
      case token_type 
      when 'keyword' then xml_file.write(JackTokenizer.get_keyword(token))
      when 'symbol' then xml_file.write(JackTokenizer.get_symbol(token))
      when 'identifier' then xml_file.write(JackTokenizer.get_identifier(token))
      when 'string_const' then xml_file.write(JackTokenizer.get_stringval(token))
      when 'int_const' then xml_file.write(JackTokenizer.get_intval(token))
      end

      xml_file.write("\r\n")
    end
    xml_file.write("</tokens>\r\n")
    xml_file.close

  end
end

main


