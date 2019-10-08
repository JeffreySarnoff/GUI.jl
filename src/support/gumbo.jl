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

function string_of_attributes(attributes::Dict) where {T}
    k, v = collect(keys(attributes)), collect(values(attributes))
    vstrs = map(s->string("\"",s,"\""), v)
    z = zip(k,vstrs)
    return join(join.(collect(z), "=")), " ")
end
  
