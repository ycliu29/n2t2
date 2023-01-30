require_relative 'FunctionClass.rb'

def main
  $line_count = 0

  target_path = ARGV[0]
  if File.file?(target_path)
    asm_f = File.open("#{ARGV[0][0..-4]}.asm", 'w')
    asm_f.write(Writer.writeInit)

    vm_f = File.open(target_path, 'r')

    vm_f.each do |line|
      $line_count += 1
      translated_line = Writer.write(Parser.parse(line))
      translated_line == nil ? nil : asm_f.write(translated_line)
    end
    
  elsif File.directory?(target_path)
    asm_f_filename = target_path.match(/\/([\w]+)$/).captures.first
    asm_f = File.open("#{asm_f_filename}.asm", 'w')
    asm_f.write(Writer.writeInit)

    dir = Dir.new(target_path)
    dir.each do |file|
      if File.extname(file) != '.vm' 
        next
      else 
        vm_path = File.join(dir.path, file)
        vm_f = File.open(vm_path, "r")
        $file_name = file[0..-4]
  
        vm_f.each do |line|
          $line_count += 1
          translated_line = Writer.write(Parser.parse(line))
          translated_line == nil ? nil : asm_f.write(translated_line)
        end
      end
    end
  end
end

main
