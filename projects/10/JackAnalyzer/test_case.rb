require './projects/10/JackAnalyzer/CompilationEngine.rb'
ce = CompilationEngine.new('./projects/10/ArrayTest/MainT.xml')
CompilationEngine.compile_class(ce)
ce.output.close



ce.tokens[0] = "<keyword> static </keyword>\r\n"
CompilationEngine.compile_class_var_dec_or_subroutine(ce)