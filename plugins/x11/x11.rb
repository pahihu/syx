
class X11Extract
    def X11Extract.parse(file)
        lines = File.readlines(file)
        funcs = {}
        func = []
        lines.each do |line|
            line.strip!
            case line
            when /^extern[ \t]+.*[ \t]+([^ \t]+)[ \t]*\($/
                fn = $1
                fname = fn.gsub(/[*]+/,'').strip
                func = []
                funcs[fname] = func
            when /\/\*(.*)\*\//
                func << $1.strip if func
            when /^\);/
                func = nil
            when /^extern[ \t]+.*[ \t]+([^ \t]+)[ \t]*\([ \t]*void[ \t]*\)[ \t]*;[ \t]*$/
                fn = $1
                fname = fn.gsub(/[*]+/,'').strip
                funcs[fname] = []
                func = nil
            end
        end
        return funcs
    end

end

class X11Parser
    def X11Parser.mangle(name)
        return name.strip.gsub(/^[a-zA-Z0-9]/) { |s|
            if s.length > 1
                s.capitalize
            else
                s
            end
        }.gsub(/_[a-zA-Z0-9]/){|s| s[1..-1].upcase}
    end
    def X11Parser.run(funcs)
        f = {}
        funcs.keys.each do |func|
            args = funcs[func]
            argdef = []
            args.each do |a|
                argdef << mangle(a)
            end
            f["prim#{mangle(func)}"] = argdef
        end
        return f
    end
end

