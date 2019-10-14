function Base.convert(::Type{Gumbo.HTMLElement}, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    str = string(x)
    htmldoc = Gumbo.parsehtml(str)
    return children(htmlbody(htmldoc))[1]
end

function Base.push!(doc::Gumbo.HTMLDocument, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    push!(htmlbody(doc), convert(Gumbo.HTMLElement, x))
end

function Base.pushlast!(doc::Gumbo.HTMLDocument, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    pushlast!(htmlbody(doc), convert(Gumbo.HTMLElement, x))
end

function Base.push!(elem::Gumbo.HTMLElement, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    push!(elem, convert(Gumbo.HTMLElement, x))
end

function Base.pushlast!(elem::Gumbo.HTMLElement, x::Hyperscript.Node{Hyperscript.HTMLSVG})
    pushlast!(elem, convert(Gumbo.HTMLElement, x))
end

