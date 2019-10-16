function Base.convert(::Type{Gumbo.HTMLElement}, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    str = string(x)
    htmldoc = Gumbo.parsehtml(str)
    return children(htmlbody(htmldoc))[1]
end

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

