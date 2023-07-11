require './JackTokenizer.rb'
require './CompilationEngine.rb'

def main()
  input_path = ARGV[0]

  if File.file?(input_path)
    build_xml_file(input_path)

  elsif File.directory?(input_path)
    jack_files = Dir.glob("#{input_path}/*.jack")

    jack_files.each do |file_path|
      build_xml_file(file_path)
    end
  end
end

def build_xml_file(jack_file_path)
  base_name = File.basename(jack_file_path, ".*")
  dir = File.dirname(jack_file_path)
  xml_file = File.open("#{dir}/#{base_name}TT.xml", 'w')

  tokenizer = JackTokenizer.new(jack_file_path)
  tokenizer.tokens = JackTokenizer.build_tokens(tokenizer.lines)

  xml_file.write("<tokens>\r\n")

  tokenizer.tokens.each do |token|
    xml_file.write(JackTokenizer.convert_token_to_xml(token))
    xml_file.write("\r\n")
  end

  xml_file.write("</tokens>\r\n")
  xml_file.close

  ce = CompilationEngine.new("#{dir}/#{base_name}TT.xml")
  ce.compile_class
  ce.output.close
end

main
