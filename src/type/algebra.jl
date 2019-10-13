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

mutable struct Context{T} <: AbstractContext
     value::T
end

mutable struct Element{T1,T2,T3}
    content::Content{T1}
    context::Context{T2}
    css_id::MaybeString
    css_class::Vector{String}
    html::Hyperscript.Node{T3}
end

function string(x::Element{T1,T2,T3}) where {T1, T2, T3}
    cssclass = isempty(x.css_class) ? "" : string("class=\"",join(x.css_class),"\"")
    cssid = isnothing(x.css_id) ? "" : string("id=\"",x.css_id,"\"")
    # ...
 end    

