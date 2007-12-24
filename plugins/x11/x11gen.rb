require 'swig'
require 'x11'

if !ARGV[0]
    puts 'Need wrap.c'
    exit -1
end

if !ARGV[1]
    puts 'Need <x11funcs>.i'
    exit -1
end

#puts "Parsing funcs #{ARGV[1]}"
funcs = X11Parser.run(X11Extract.parse(ARGV[0]))
#puts "Parsing structs #{ARGV[0]}"
structs = SwigParser.run(SwigExtract.parse(ARGV[0]))
xlib = structs.delete('Xlib')
puts SwigGenerate.dofile('Xlib', xlib, funcs, true)

structs.keys.each do |k|
    puts SwigGenerate.dofile(k, structs[k], funcs)
end

