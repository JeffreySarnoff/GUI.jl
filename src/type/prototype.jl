#=
    using the machinery NamedTupleTools 

    prototypes
      NamedTuple{(:a, :b, :c),T} where T<:Tuple

    nt.fieldname
=#

#=
    using the machinery of Hyperscript supporting tag elaboration
=#

#=
   sorts of Content
=#

@enum AkoContent akoNothing=1 akoText akoImage akoForm

const akoContent = Dict(Nothing=>akoNothing, :text=>akoText, :img=>akoImage, :image=>akoImage, :form=>akoForm)
AkoContent(x::Symbol) = get(akoContent, x, nothing)

mutable struct Content{T} <: AbstractContent
    ako::AkoContent
    value::T
    
    function Content(value::T) where {T}
        ako = AkoContent(T)
        isnothing(ako) && println("\n\t missing AkoContent for ",T,"\n")
        return new{T}(ako, value)
    end    
end

const MaybeContent{T} = Union{Nothing, Content{T}}
iscontent(x::MaybeContent{T}) where {T} = !isnothing(x)
iscontent(x::Content{T}) where {T} = true
iscontent(x) = false

#=
   sorts of Context
=#

@enum AkoContext akoNothing=1 akoTable akoList akoEntry

const akoContext = Dict(Nothing=>akoNothing, :table=>akoTable, :ol=>akoList, :ul=>akoList, :form=>akoEntry)
AkoContext(x::Symbol) = get(akoContext, x, nothing)
        

mutable struct Context{T} <: AbstractContext
    ako::AkoContext
    value::T

    function Context(value::T) where {T}
        ako = AkoContext(T)
        isnothing(ako) && println("\n\t missing AkoContext for ",T,"\n")
        return new{T}(ako, value)
    end    
end

const MaybeContext{T} = Union{Nothing, Context{T}}
iscontext(x::MaybeContext{T}) where {T} = !isnothing(x)
iscontext(x::Context{T}) where {T} = true
iscontext(x) = false
