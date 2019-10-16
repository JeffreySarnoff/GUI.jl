export htmldoc, htmlroot, htmlhead, htmlbody, attributes, attribute_names, attribute_values,
    pushfirst_sibling!, push_sibling!, pushfirst_child!, push_child!

import Base: string

const EmptyHtmlDoc = Gumbo.parsehtml("")
htmldoc() = deepcopy(EmptyHtmlDoc)

push_sibling!(elem::Gumbo.HTMLElement,val) = push!(elem, val)
pushfirst_sibling!(elem::Gumbo.HTMLElement,val) = pushfirst!(elem, val)
push_child!(elem::Gumbo.HTMLElement,val) = push!(elem.children, val)
pushfirst_child!(elem::Gumbo.HTMLElement,val) = pushfirst!(elem.children, val)

const HTMLTextTag = "(_)" 
Gumbo.tag(x::Gumbo.HTMLText) = HTMLTextTag

htmldoctype(x::Gumbo.HTMLDocument) = x.doctype
htmlroot(x::Gumbo.HTMLDocument) = x.root
htmlhead(x::Gumbo.HTMLDocument) = children(x.root)[1]
htmlbody(x::Gumbo.HTMLDocument) = children(x.root)[2]

Base.parentelement(x::Gumbo.HTMLELement) = x.parent

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
  headstr = string(HTMLElement{:head}, x[1])
  bodystr = string(HTMLElement{:body}, x[2])
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

function stringcontent(::Type{HTMLElement{T}}, x) where {T}
  content = 
  return string("<",T,"></",T,">")
end


function string_of_attributes(attributes::Dict) where {T}
    k, v = collect(keys(attributes)), collect(values(attributes))
    vstrs = map(s->string("\"",s,"\""), v)
    z = zip(k,vstrs)
    return join(join.(collect(z), "="), " ")
end
  


#=
prettyhtml(x::AbstractString) = prettyhtml(Gumbo.parsehtml(x))

function prettyhtml(x::Gumbo.HTMLDocument)
    io = IOBuffer()
    Gumbo.prettyprint(io, x)
    s = String(take!(io))
    return s
end    
=#

#=
htmlstr = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css"></link>
  </head>
  <body class="body">
    <div class="plain">
      content
    </div> 
    <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
  </body>
</html>
"""

htmlstr = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css" />
  </head>
  <body class="bodyclass">
    <div class="wrapper" id="backdrop">
      <div class="plain" id="interior">
        <span class="plain" id="words">
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
=#
