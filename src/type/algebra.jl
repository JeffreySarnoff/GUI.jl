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


mutable struct HtmlElement{N}
    htmlelem::Symbol
    hyperelem::Function
    cssclass::MaybeNTuple{N,String}
    cssid::MaybeString

    function HtmlElement(elem::Symbol, cssclass::MaybeNTuple{N,String}=nothing; id::MaybeString=nothing) where {N}
       hyperelem = hyperhtml[elem] 
       return new{isnothing(cssclass) ? 0 : N}(elem, hyperelem, cssclass, id)
    end
    
    function HtmlElement(elem::Symbol, cssclass::String; id::MaybeString=nothing) where {N}
       hyperelem = hyperhtml[elem] 
       return new{1}(elem, hyperelem, (cssclass,), id)
    end
end

function hyperelem(x::HtmlElement{N}) where {N}
    if !isnothing(x.cssclass)
        classes = join(x.cssclass, " ")
        if !isnothing(x.cssid)
            x.hyperelem(classes, :id=>id)
        else
            x.hyperelem(classes)
        end
    elseif !isnothing(x.cssid)
        x.hyperelem(:id=>id)
    else
        x.hyperelem()
    end
end
