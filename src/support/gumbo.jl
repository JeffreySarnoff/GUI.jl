import Base: string

# subtypes(HTMLNode) == [ HTMLElement, HTMLText, NullNode ]

typeofnode(x::HTMLElement{T}) where {T} = T
typeofnode(x::HTMLText) = String
typeofnode(x::NullNode) = Nothing

attributes(x::HTMLElement{T}) where {T} = x.attributes
# attribute_pairs(x::HTMLElement{T}) where {T} = 
attribute_names(x::HTMLElement{T}) where {T}  = keys(attributes(x))
attribute_values(x::HTMLElement{T}) where {T} = values(attributes(x))

function string(::Type{HTMLElement{:HTML}}, x, lang="en")
  doctypestr = "<!DOCTYPE html>"
  htmlstr = string("<html lang=\"", lang, "\">")
  headstr = string(::Type{HTMLElement{:head}}, x[1])
  bodystr = string(::Type{HTMLElement{:body}}, x[2])
  return join((doctypestr, htmlstr, headstr, "</head>", bodystr, "</body>", "</html>\n"), "\n")
end

function string(::Type{HTMLElement{:head}}, x)
    
end

function string(::Type{HTMLElement{:body}}, x)
    atrs = attrs(x)
    if isempty(atrs)
        result = "<body>\n"
    else
        result = string("<body ", string_of_attributes(atrs),">\n")
    end
    for child in children(x)
        result = string(result, "  ", string(typeof(child), child))
    end
    result = string(result, "</body>\n")
    return result
end

function string(::Type{HTMLElement{T}}, x) where {T}
    attrs = attributes(x)
    isempty(attrs) && return stringcontent(HTMLElement{T})
    childs = children(x)
    while !isempty(childs)
       return string(typeof(childs), childs)
    end
    return ""
end

fucntion stringcontent(::Type{HTMLElement{T}}, x) where {T}
  content = 
  return string("<",T,"></",T,">")
end
#=

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Title of document</title>
</head>
<body>
<h1>XHTML made easy</h1>
This is not as hard as I thought it would be.
I might really like this.
</body>
</html>

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
    <div class="copyright" id="interior">
      <span class="plain" id="copyright">© 2019 Jeffrey Sarnoff. All Rights Reserved.</span>
    </div>
  </div>
  <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</body>
</html>
"""

function opentag(str::AbstractString)
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

function closetag(str::AbstractString)
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

function prettyxml(x::AbstractString)
    strs = strip.(String.(split(x, "\n")))
    prettystrs = Vector{String}(undef, length(strs))
    indent = ""
    idx = 1
    for str in strs
        open_tag = opentag(str)
        bothtags = !isnothing(open_tag) && (str[end-1:end] == "/>" || occursin(string("</",open_tag,">"), str))
        if bothtags
           s = string(indent, str)
        else
           close_tag = closetag(str)
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

xhtmldoc = EzXML.parsehtml(xhtmlstr)
xhtmlroot = xhtmldoc.root

io = IOBuffer()
EzXML.print(io, xhtmlroot)
str = String(take!(io))

pretty = prettyxml(str)
print(pretty)
=#


#=

xhtmlhead = elements(xhtmlroot)[1]
xhtmlbody = elements(xhtmlroot)[2]

EzXML.prettyprint(xhtmlhead)
EzXML.prettyprint(xhtmlbody)

io = IOBuffer()
EzXML.prettyprint(io, xhtmlbody)
str = String(take!(io))
bodystr = replace(str, "  "=>"")
print(bodystr)

function opentagfromstr(str::AbstractString)
    (length(str) < 2 || str[2] === '/') && return nothing
    tagstr = tagfromstr(str)
    isnothing(tagstr) && return nothing
    (str[end] === '>' && last(findlast(tagstr, str)) > length(str) - 2) && return nothing
    return tagstr
end

function closetagfromstr(str::AbstractString)
    (length(str) < 2 || str[2] !== '/') && return nothing
    tagstr = tagfromstr(str)
    return tagstr
end


function tagfromstr(str::AbstractString)
    (length(str) < 2 || str[1] !== '<') && return nothing
    if str[2] === '/'
        tag = rstrip(str[3:end-1])
    else
       endatidx = findfirst(" ", str)
       if isnothing(endatidx)
           endatidx = findfirst(">", str)
           isnothing(endatidx) && return nothing
           endidx = first(endatidx)
       else
           endidx = first(endatidx)
       end
       endidx = endidx - 1
       tag = str[2:endidx]
    end
    return tag
end

istagopen(str::String) = length(str) > 1 && str[2] !== '/' 
istagclose(str::String) = length(str) > 1 && str[2] === '/'

bodystrs = String.(split(bodystr, "\n"))

prettybodystrs = Vector{String}(undef, length(bodystrs))
indent = ""
idx = 1
for str in bodystrs
    global idx, indent
    opentag = opentagfromstr(str)
    closetag = closetagfromstr(str)
    if !isnothing(opentag)
       s = string(indent, str)
       indent = string(indent, "  ")
    elseif !isnothing(closetag)
       indent = indent[1:end-2]
       s = string(indent, str)
    else
       s  = string(indent, str)
    end
    prettybodystrs[idx] = s; println(length(indent))
    idx += 1
end

prettybody = join(prettybodystrs, "\n")

julia> print(prettybody)
<body class="bodyclass">
  <div class="wrapper" id="backdrop">
    <div class="plain" id="interior">
      <span class="plain" id="words">these words</span>
    </div>
    <div class="copyright" id="interior">
      <span class="plain" id="copyright">© 2019 Jeffrey Sarnoff. All Rights Reserved.</span>
    </div>
  </div>
  <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</body>




htmlstr = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css">"
  </head>
  <body class="bodyclass">
    <div class="wrapper"id="backdrop">
      <div class="plain"id="interior">
        <span class="plain"id="words">
          these words
        </span>
      </div>
    </div> 
    <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
  </body>
</html>
"""

htmldoc = Gumbo.parsehtml(htmlstr)
htmlroot = htmldoc.root
htmlhead = htmlroot[1]
htmlbody = htmlroot[2]


julia>

julia> text(r[2][2][1][1])
"these words"



julia> source = "<div>first div</div><div>second div</div>"
"<div>first div</div><div>second div</div>"

julia> substitute(match) = match[1] * "\n" * match[2]
substitute (generic function with 1 method)

julia> replace(source, r">." => substitute)
"<div>\nfirst div</div>\n<div>\nsecond div</div>"

julia> print(ans)
<div>
first div</div>
<div>
second div</div>
julia>                                    



julia> tst = replace(prettybody, r">." => substitute)

julia> print(tst)
<body class="bodyclass">
  <div class="wrapper" id="backdrop">
    <div class="plain" id="interior">
      <span class="plain" id="words">
these words</span>
    </div>
    <div class="copyright" id="interior">
      <span class="plain" id="copyright">
© 2019 Jeffrey Sarnoff. All Rights Reserved.</span>
    </div>
  </div>
  <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js">
</script>
</body>

=#

function string_of_attributes(attributes::Dict) where {T}
    k, v = collect(keys(attributes)), collect(values(attributes))
    vstrs = map(s->string("\"",s,"\""), v)
    z = zip(k,vstrs)
    return join(join.(collect(z), "=")), " ")
end
  
