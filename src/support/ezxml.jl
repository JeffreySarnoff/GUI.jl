prettyhtml(x::AbstractString) = prettyhtml(Gumbo.parsehtml(x))

function prettyhtml(x::Gumbo.HTMLDocument)
    s = string(x)
    s = replace(s, r">\"\n.*\n.*\n" => ">\n") # fix problem in Gumbo parser with "<body ...>"
    return prettyxml(s)
 end    

prettyxml(x::EzXML.Document) = prettyxml(root(x))

function prettyxml(x::EzXML.Node)
    io = IOBuffer()
    EzXML.print(io, x)
    str = String(take!(io))
    return prettyxml(str)
end

function prettyxml(x::AbstractString)
    s = join(split(s,"><"),">\n<")
    strs = strip.(String.(split(s, "\n")))
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

#=
xhtmlstr = """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Title</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css" />
</head>
<body class="bodyclass">
  <div class="wrapper" id="backdrop">
    <div class="plain" id="interior">
      <span class="plain"id="words">these words</span>
    </div>
    <div class="copyright">
      <span class="plain" id="copyright">© 2019 Jeffrey Sarnoff. All Rights Reserved.</span>
    </div>
  </div>
  <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</body>
</html>
"""
=#
