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

@enum AkoContent noContent=1 akoText akoImage akoForm akoInteger akoFloat akoNumber

const akoContent = Dict(:nothing=>noContent, :Nothing=>noContent,
    :text=>akoText, :string=>akoText, :AbstractString=>akoText,
    :img=>akoImage, :image=>akoImage, :form=>akoForm,
    :Int8=>akoInteger, :Int16=>akoInteger, :Int64=>akoInteger, :Int64=>akoInteger, :Integer=>akoInteger,
    :Float16=>akoFloat, :Float32=>akoFloat, :Float64=>akoFloat, :AbstractFloat=>akoFloat, :Number=>akoNumber)

AkoContent(x::Symbol) = get(akoContent, x, nothing)

mutable struct Content{T} <: AbstractContent
    ako::AkoContent
    value::T
    
    function Content(value::T) where {T}
        ako = AkoContent(Symbol(T))
        if isnothing(ako)
            ako = AkoContent(Symbol(supertype(T)))
        end    
        isnothing(ako) && println("\n  >>>  missing AkoContent for ",T," <: ", supertype(T), "\n")
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

@enum AkoContext noContext=1 akoTable akoList akoEntry

const akoContext = Dict(:nothing=>noContext, :Nothing=>noContext,
    :table=>akoTable, :ol=>akoList, :ul=>akoList, :form=>akoEntry)

AkoContext(x::Symbol) = get(akoContext, x, nothing)

mutable struct Context{T} <: AbstractContext
    ako::AkoContext
    value::T

    function Context(value::T) where {T}
        ako = AkoContext(Symbol(T))
        if isnothing(ako)
            ako = AkoContext(Symbol(supertype(T)))
        end    
        isnothing(ako) && println("\n  >>>  missing AkoContext for ",T," <: ", supertype(T), "\n")
        return new{T}(ako, value)
    end    
end

const MaybeContext{T} = Union{Nothing, Context{T}}
iscontext(x::MaybeContext{T}) where {T} = !isnothing(x)
iscontext(x::Context{T}) where {T} = true
iscontext(x) = false
