require_relative 'FunctionClass.rb'

$line_count = 0

def main
  # open, create necessary files
  target_file = ARGV[0]
  vm_f = File.open(target_file, 'r')
  asm_f = File.open("#{ARGV[0][0..-4]}.asm", 'w')

  # iterate line by line
  vm_f.each do |line|
    $line_count += 1
    translated_line = Writer.write(Parser.parse(line))
    translated_line == nil ? nil : asm_f.write(translated_line)
  end
end

main