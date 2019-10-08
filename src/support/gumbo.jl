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
hese words"

julia> r
HTMLElement{:HTML}:
<HTML lang="en">
  <head></head>
  <body hidden="hidden"class="bodyclass">
    <div class="wrapper"id="backdrop"></div>
    <div class="plain"id="interior">
      <span class="plain"id="words">
        these words
      </span>
    </div>
  </body>
</HTML>


julia>

julia> text(r[2][2][1][1])
"these words"

=#

function string_of_attributes(attributes::Dict) where {T}
    k, v = collect(keys(attributes)), collect(values(attributes))
    vstrs = map(s->string("\"",s,"\""), v)
    z = zip(k,vstrs)
    return join(join.(collect(z), "=")), " ")
end
  
