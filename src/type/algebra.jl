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

hyperhtml(x::Nothing) = nothing
hyperhtml(x::Context{T}) where {T} = hyper(x.value)
hyperhtml(x::Content{T}) where {T} = hyper(x.value)
hyperhtml(x::String) = x

function hyperhtml(x::HtmlElement)
    context = hyperhtml(x.context)
    content = hyperhtml(x.content)
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
julia> asection = HtmlElement(:section, ("asection",))
HtmlElement(:section, GUI.section_, ("asection",), nothing)

julia> adiv=HtmlElement(:div, "adiv")
HtmlElement(:div, GUI.div_, ("adiv",), nothing)

julia> alink=HtmlElement(:a, ("alink"))
HtmlElement(:a, GUI.a_, ("alink",), nothing)

julia> hyperhtml(asection)
<section class="asection"></section>

julia> hyperhtml(adiv)
<div class="adiv"></div>

julia> hyperhtml(alink)
<a class="alink"></a>

julia> hyperhtml(adiv)(hyperhtml(alink))
<div class="adiv"><a class="alink"></a></div>

julia> hyperhtml(adiv)(hyperhtml(alink)("url"))
<div class="adiv"><a class="alink">url</a></div>

julia> hyperhtml(adiv),hyperhtml(alink)("url")
(<div class="adiv"></div>, <a class="alink">url</a>)

julia> hyperhtml(asection)(hyperhtml(adiv),hyperhtml(alink)("url"))
<section class="asection"><div class="adiv"></div><a class="alink">url</a></section>

julia> bdiv = HtmlElement(:div, "bdiv", context=Context(adiv))
HtmlElement(:div, GUI.div_, ("bdiv",), nothing, nothing, Context{HTML_Element}(HTML_Element(:div, GUI.div_, ("adiv",), nothing)))

julia> hyperhtml(bdiv)
<div class="bdiv"><div class="adiv"></div></div>

julia> hyperhtml(bdiv)("b")
<div class="bdiv"><div class="adiv"></div>b</div>


julia> bdiv = GUI.HtmlElement(:div, "bdiv", content=GUI.Content("ab"), context=GUI.Context(alink))
GUI.HtmlElement(:div, GUI.div_, ("bdiv",), nothing, GUI.Content{String}("ab"), GUI.Context{GUI.HtmlElement}(GUI.HtmlElement(:a, GUI.a_, ("alink blink",), "id", nothing, nothing)))

julia> hyperhtml(bdiv)
<div class="bdiv">ab<a class="alink blink" id="id"></a></div>

julia> bdiv = GUI.HtmlElement(:div, "bdiv", content=GUI.Content(alink), context=GUI.Context("abcd"))
GUI.HtmlElement(:div, GUI.div_, ("bdiv",), nothing, GUI.Content{GUI.HtmlElement}(GUI.HtmlElement(:a, GUI.a_, ("alink blink",), "id", nothing, nothing)), GUI.Context{String}("abcd"))

julia> hyperhtml(bdiv)
<div class="bdiv"><a class="alink blink" id="id"></a>abcd</div>

=#


#=
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


function hyperhtml(x::HTML_Element)
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
=#
