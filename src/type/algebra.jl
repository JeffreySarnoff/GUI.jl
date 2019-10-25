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

mutable struct HtmlElement
    htmlelem::Symbol
    hyperelem::Function
    cssclass::MaybeTuple
    cssid::MaybeString
    content::MaybeContent
    context::MaybeContext

    function HtmlElement(elem::Symbol, cssclass::MaybeNTuple{N,String}=nothing; id::MaybeString=nothing, 
                         content::MaybeContent=nothing, context::MaybeContext=nothing) where {N}
       helem = HyperHtml[elem] 
       return new(elem, helem, cssclass, id, content, context)
    end
    
    function HtmlElement(elem::Symbol, cssclass::String; id::MaybeString=nothing,
                         content::MaybeContent=nothing, context::MaybeContext=nothing)
       helem = HyperHtml[elem] 
       return new(elem, helem, (cssclass,), id, content, context)
    end
end

Base.string(io::IO, x::HtmlElement) = string(io, hyperhtml(x))
Base.string(x::HtmlElement) = string(hyperhtml(x))

render(io::IO, x::HtmlElement) = Hyperscript.render(io, Hyperscript.Pretty(hyperhtml(x)))
render(x::HtmlElement) = Hyperscript.render(stdout, Hyperscript.Pretty(hyperhtml(x)))


hyperhtml(x::Nothing) = nothing
hyperhtml(x::Context{T}) where {T} = hyperhtml(x.value)
hyperhtml(x::Content{T}) where {T} = hyperhtml(x.value)
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
asection = HtmlElement(:section, ("asection",)) # HtmlElement(:section, GUI.section_, ("asection",), nothing)
adiv=HtmlElement(:div, "adiv") # HtmlElement(:div, GUI.div_, ("adiv",), nothing)
alink=HtmlElement(:a, ("alink")) # HtmlElement(:a, GUI.a_, ("alink",), nothing)

hyperhtml(asection) # <section class="asection"></section>
hyperhtml(adiv) # <div class="adiv"></div>
hyperhtml(alink) # <a class="alink"></a>

hyperhtml(adiv)(hyperhtml(alink)) # <div class="adiv"><a class="alink"></a></div>
hyperhtml(adiv)(hyperhtml(alink)("url")) # <div class="adiv"><a class="alink">url</a></div>
hyperhtml(adiv),hyperhtml(alink)("url") # (<div class="adiv"></div>, <a class="alink">url</a>)
hyperhtml(asection)(hyperhtml(adiv),hyperhtml(alink)("url")) # <section class="asection"><div class="adiv"></div><a class="alink">url</a></section>

bdiv = HtmlElement(:div, "bdiv", context=Context(adiv)) # HtmlElement(:div, GUI.div_, ("bdiv",), nothing, nothing, Context{HTML_Element}(HTML_Element(:div, GUI.div_, ("adiv",), nothing)))
hyperhtml(bdiv) # <div class="bdiv"><div class="adiv"></div></div>
hyperhtml(bdiv)("b") # <div class="bdiv"><div class="adiv"></div>b</div>

cdiv = HtmlElement(:div, "cdiv", content=GUI.Content("inside cdiv"), context=GUI.Context(alink)) # HtmlElement(:div, GUI.div_, ("ddiv",), nothing, Content{HtmlElement}(HtmlElement(:a, GUI.a_, ("alink",), nothing, nothing, nothing)), Context{String}("abcd"))
hyperhtml(cdiv) # <div class="cdiv">inside cdiv<a class="alink"></a></div>

ddiv = HtmlElement(:div, "ddiv", content=GUI.Content(alink), context=GUI.Context("abcd")) # HtmlElement(:div, GUI.div_, ("ddiv",), nothing, Content{HtmlElement}(HtmlElement(:a, GUI.a_, ("alink",), nothing, nothing, nothing)), Context{String}("abcd"))
hyperhtml(ddiv) # <div class="ddiv"><a class="alink"></a>abcd</div>
=#

