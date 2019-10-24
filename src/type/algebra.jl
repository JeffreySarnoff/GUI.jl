#=
    AbstractGUI
      AbstractContext, AbsractContent
         AbstractConstrain, AbstractConstruct, AbstractContemper


                                                   AbstractGUI
                            AbstractContext                                     AbstractContent
                   AbstractConstrainContext                             AbstractConstrainContent
                   AbstractConstructContext                             AbstractConstructContent
                   AbstractContemperContext                             AbstractContemperContent

=#

#=
    An Algebra of Content and Context

    Jeffrey Sarnoff 2019-Oct-09

    Context pervades, informs, reflects  Content
    Content suffuses, regards, mapsfrom  Context

    meld   ::  [A, A] => A
    whole   :: [B, B] => B
    pervade :: [A, B] => B
    inform  :: [A, B] => B
    suffuse :: [B, A] => A
    regard  :: [B, A] => A    

=#

mutable struct Content{T} <: AbstractContent
     value::T
end

const MaybeContent{T} = Union{Nothing, Content{T}}
iscontent(x::MaybeContent{T}) where {T} = !isnothing(x)
iscontent(x::Content{T}) where {T} = true
iscontent(x) = false

mutable struct Context{T} <: AbstractContext
     value::T
end

const MaybeContext{T} = Union{Nothing, Context{T}}
iscontext(x::MaybeContext{T}) where {T} = !isnothing(x)
iscontext(x::Context{T}) where {T} = true
iscontext(x) = false


mutable struct HTML_Element
    htmlelem::Symbol
    hyperelem::Function
    cssclass::MaybeTuple
    cssid::MaybeString

    function HTML_Element(elem::Symbol, cssclass::MaybeNTuple{N,String}=nothing; id::MaybeString=nothing) where {N}
       helem = hyperhtml[elem] 
       return new(elem, helem, cssclass, id)
    end
    
    function HTML_Element(elem::Symbol, cssclass::String; id::MaybeString=nothing)
       helem = hyperhtml[elem] 
       return new(elem, helem, (cssclass,), id)
    end
end


function hyper(x::HTML_Element)
    if !isnothing(x.cssclass)
        classes = join(x.cssclass, " ")
        if !isnothing(x.cssid)
            x.hyperelem(classes, :id=>x.cssid)
        else
            x.hyperelem(classes)
        end
    elseif !isnothing(x.cssid)
        x.hyperelem(:id=>x.cssid)
    else
        x.hyperelem()
    end
end

#=
julia> asection = HTML_Element(:section, ("asection",))
HTML_Element(:section, GUI.section_, ("asection",), nothing)

julia> adiv=HTML_Element(:div, "adiv")
HTML_Element(:div, GUI.div_, ("adiv",), nothing)

julia> alink=HtmlElement(:a, ("alink"))
HTML_Element(:a, GUI.a_, ("alink",), nothing)

julia> hyper(asection)
<section class="asection"></section>

julia> hyper(adiv)
<div class="adiv"></div>

julia> hyper(alink)
<a class="alink"></a>

julia> hyper(adiv)(hyper(alink))
<div class="adiv"><a class="alink"></a></div>

julia> hyper(adiv)(hyper(alink)("url"))
<div class="adiv"><a class="alink">url</a></div>

julia> hyper(adiv),hyper(alink)("url")
(<div class="adiv"></div>, <a class="alink">url</a>)

julia> hype(asection)(hyper(adiv),hyper(alink)("url"))
<section class="asection"><div class="adiv"></div><a class="alink">url</a></section>
=#

mutable struct HtmlElement
    htmlelem::Symbol
    hyperelem::Function
    cssclass::MaybeTuple
    cssid::MaybeString
    content::MaybeContent
    context::MaybeContext

    function HtmlElement(elem::Symbol, cssclass::MaybeNTuple{N,String}=nothing; id::MaybeString=nothing, 
                         content::MaybeContent=nothing, context::MaybeContext=nothing) where {N}
       helem = hyperhtml[elem] 
       return new(elem, helem, cssclass, id, content, context)
    end
    
    function HtmlElement(elem::Symbol, cssclass::String; id::MaybeString=nothing,
                         content::MaybeContent=nothing, context::MaybeContext=nothing)
       helem = hyperhtml[elem] 
       return new(elem, helem, (cssclass,), id, content, context)
    end
end

hyper(x::Nothing) = nothing
hyper(x::Context{T}) where {T} = hyper(x.value)
hyper(x::Content{T}) where {T} = hyper(x.value)

function hyper(x::HtmlElement)
    context = hyper(x.context)
    content = hyper(x.content)
    result =
        if !isnothing(x.cssclass)
            classes = join(x.cssclass, " ")
            if !isnothing(x.cssid)
                x.hyperelem(classes, :id=>x.cssid)
            else
                x.hyperelem(classes)
            end
        elseif !isnothing(x.cssid)
            x.hyperelem(:id=>x.cssid)
        else
            x.hyperelem()
        end
    if !isnothing(context)
        if !isnothing(content)
            result(content,context)
        else
            result(context)
        end
    elseif !isnothing(content)
        result(content)
    else
        result
    end
end

#=

julia> bdiv = HtmlElement(:div, "bdiv", context=Context(adiv))
HtmlElement(:div, GUI.div_, ("bdiv",), nothing, nothing, Context{HTML_Element}(HTML_Element(:div, GUI.div_, ("adiv",), nothing)))

julia> hyper(bdiv)
<div class="bdiv"><div class="adiv"></div></div>


julia> hyper(bdiv)("b")
<div class="bdiv"><div class="adiv"></div>b</div>

=#
