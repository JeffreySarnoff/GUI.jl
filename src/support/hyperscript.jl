function Base.convert(::Type{Gumbo.HTMLElement}, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    str = string(x)
    htmldoc = Gumbo.parsehtml(str)
    return children(htmlbody(htmldoc))[1]
end

#=
    push!(doc, node), pushfirst!(doc, node)
    create siblings at the body level

    push!(element, node), pushfirst!(element, node)
    create children at the element level

    to create siblings at the element level, use children(parentelement(element))
=#

function Base.push!(doc::Gumbo.HTMLDocument, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    push!(htmlbody(doc), convert(Gumbo.HTMLElement, x))
end

function Base.pushfirst!(doc::Gumbo.HTMLDocument, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    pushfirst!(htmlbody(doc), convert(Gumbo.HTMLElement, x))
end

function Base.push!(elem::Gumbo.HTMLElement, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    push!(elem, convert(Gumbo.HTMLElement, x))
end

function Base.pushfirst!(elem::Gumbo.HTMLElement, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    pushfirst!(elem, convert(Gumbo.HTMLElement, x))
end

