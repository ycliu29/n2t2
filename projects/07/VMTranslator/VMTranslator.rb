require_relative 'FunctionClass.rb'

def main
  # open, create necessary files
  target_file = ARGV[0]
  vm_f = File.open(target_file, 'r')
  asm_f = File.open("#{ARGV[0][0..-4]}.asm", 'w')

  # iterate line by line
  vm_f.each do |line|
    asm_f.write(line)
  end
end

main