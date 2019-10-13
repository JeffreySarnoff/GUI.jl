import Base: string

prettyhtml(x::AbstractString) = prettyhtml(Gumbo.parsehtml(x))

function prettyhtml(x::Gumbo.HTMLDocument)
    s = string(x)
    return prettyxml(s)
end    

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
