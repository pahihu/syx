require 'swig'
require 'x11'

if !ARGV[0] || ARGV[0] !~ /wrap\.c$/
    puts 'Need wrap.c'
    exit -1
end

if !ARGV[1] || ARGV[1] !~ /\.i$/
    puts 'Need <x11funcs>.i'
    exit -1
end

#puts "Parsing funcs #{ARGV[1]}"
funcs = X11Parser.run(X11Extract.parse(ARGV[0]))
#puts "Parsing structs #{ARGV[0]}"
structs = SwigParser.run(SwigExtract.parse(ARGV[0]))
xlib = structs.delete('')
puts SwigGenerate.dofile('', xlib, funcs, true)

structs.keys.each do |k|
    puts SwigGenerate.dofile(k, structs[k], funcs)
end

