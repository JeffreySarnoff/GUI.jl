

function prettyxml(x::EzXML.Node)
    io = IOBuffer()
    EzXML.print(io, xhtmlroot)
    str = String(take!(io))
    return prettyxml(str)
end

function prettyxml(x::AbstractString)
    strs = strip.(String.(split(x, "\n")))
    prettystrs = Vector{String}(undef, length(strs))
    indent = ""
    idx = 1
    for str in strs
        open_tag = openxmltag(str)
        bothtags = !isnothing(open_tag) && (str[end-1:end] == "/>" || occursin(string("</",open_tag,">"), str))
        if bothtags
           s = string(indent, str)
        else
           close_tag = closexmltag(str)
           if !isnothing(open_tag)
               s = string(indent, str)
               indent = string(indent, "  ")
           elseif !isnothing(close_tag)
               indent = indent[1:end-2]
               s = string(indent, str)
           else
               s  = string(indent, str)
           end
       end
       prettystrs[idx] = s
       idx += 1
    end
    return join(prettystrs, "\n")
end


function openxmltag(str::AbstractString)
   (length(str) < 2 || str[1] !== '<' || str[2] === '/') && return nothing
   firstspace = findfirst(" ", str)
   if isnothing(firstspace)
       firstclose = findfirst(">", str)
       if isnothing(firstclose)
           tag = str[2:end]
       else
           tag = str[2:first(firstclose)-1]
       end
   else
       tag = str[2:first(firstspace)-1]
   end
   return tag
end

function closexmltag(str::AbstractString)
   (length(str) < 2 || str[1] !== '<' || str[2] !== '/') && return nothing
   firstspace = findfirst(" ", str)
   if isnothing(firstspace)
       if str[end] === '>'
           tag = str[3:end-1]
       else
           tag = str[3:end]
       end
   else
       tag = str[3:first(firstspace)-1]
   end
   return tag
end
