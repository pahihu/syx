LIC =<<LIC
"
Copyright (c) 2007 Rahul, Luca Bruno
This file is part of Smalltalk YX.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
  
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
   
THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
DEALINGS IN THE SOFTWARE.
"
LIC

MODULE = 'X11'
GLOBAL = ''

class SwigExtract
    def SwigExtract.parse(fn)
        functions = []
        lines = File.readlines(fn)
        func = nil
        lines.each do |line|
            case line
            when /SYX_FUNC_PRIMITIVE\(#{MODULE}_(.*)\)$/
                func = {:name => $1,  :class => GLOBAL}
                if func[:name] =~ /new_(.*)$/
                    func[:class] = $1
                end
                functions << func
            when /SWIG_FIRST_SELF\(arg1,([^,]+),/
                # Should catch struct members too.
                c = $1.gsub(/[*]+/,'').strip
                func[:class] = c
            end
        end
        return functions
    end
end

# all _get _set and _new_ and _delete_ methods
class SwigParser
    def SwigParser.run(funcs)
        structs = {}
        struct = {}
        funcs.each do |k|
            cl = k[:class]
            name = k[:name]
            next if cl =~ /struct /
            structs[cl] ||= {}
            structs[cl][:members] ||= []
            structs[cl][:functions] ||= []
            case name
            when /^#{cl}_(.*)_get$/
                structs[cl][:members] << $1
            when /^#{cl}_(.*)_set$/
                #ignore
            when /^(new|delete)_.*/
                #ignore
            else
                structs[cl][:functions] << name
            end
        end
        return structs
    end
end

class SwigGenerate
    def SwigGenerate.mangle(name)
        return name.gsub(/^[a-zA-Z0-9]/) {|s| s.capitalize}.gsub(/_[a-zA-Z0-9]/){|s| s[1..-1].upcase}
    end
    def SwigGenerate.dofile(name, struct, funcs, isclass=false)

        access = ""
        struct[:members].each do |mem|
            mmname = mangle(mem)
            mname = mangle(name)
            prim =<<PRIM
"_________________________________________________________"
"#{mem} primitive accessors"
prim#{mname}#{mmname}
    <cCall: '#{MODULE}_#{name}_#{mem}_get' plugin: 'x11'>
    self primitiveFailed
!
prim#{mname}#{mmname}: val
    <cCall: '#{MODULE}_#{name}_#{mem}_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"#{mem} accessors"
#{mmname.downcase}
    ^self prim#{mname}#{mmname}
!
#{mmname.downcase}: val
    ^self prim#{mname}#{mmname}: val
!

PRIM
            access += prim
        end
        
        functions = ""
        struct[:functions].each do |fname|
            mname = mangle(fname)
            pname = "prim#{mname}"
            farr = funcs[pname]
            fdef = nil
            if farr
                idx = 0
                farr.each do |f|
                    if isclass
                        if idx == 0
                            fdef = ': arg1'
                            idx += 1
                            next 
                        end
                        fdef += " #{f}: arg#{idx+1}"
                    else
                        #first arg is self
                        if (idx == 0) 
                            idx += 1
                            next
                        end
                        if (idx == 1)
                            idx += 1
                            fdef = ': arg1'
                            next
                        end
                        fdef += " #{f}: arg#{idx+2}"
                    end
                    idx += 1
                end
            end
            fdef = "#{pname}#{fdef}"
            prim = ''
            if farr.nil?
                prim =<<PRIM
"_________________________________________________________"
"#{fname} primitive function commented out."
"#{fdef}"
PRIM
            else
                prim =<<PRIM
"_________________________________________________________"
"#{fname} primitive function"
#{fdef}
    <cCall: '#{MODULE}_#{mname}' plugin: 'x11'>
    self primitiveFailed
!

PRIM
            end
            functions += prim
        end
        structname = MODULE+mangle(name)

        create = ''
        delete = ''
        create =<<C if !isclass

prim#{structname}Create
    <cCall: '#{MODULE}_new_#{name}' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self prim#{structname}Create).
!
C

        delete=<<D if !isclass

prim#{structname}Delete
    <cCall: '#{MODULE}_delete_#{name}' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self prim#{structname}Delete.
!
D

        tmpl=<<TMPL
CStruct subclass: ##{structname}
        instanceVariableNames: ''
        classVariableNames: ''!

!#{structname} class methodsFor: 'initialize-release'!
#{create}
initialize
    finalizationRequest := true.
! !

!#{structname} #{'class' if isclass} methodsFor: '#{MODULE}'!

#{access}

#{functions}

#{delete}

name
    ^'#{structname}'

! !

!#{structname} methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!#{structname} methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
TMPL

        return tmpl
    end
end

