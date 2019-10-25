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

@enum AkoContent noContent=1 akoTextual akoImage akoTable akoListed akoForm akoInteger akoFloat akoNumber

const akoContent = Dict(:nothing=>noContent, :Nothing=>noContent,
    :text=>akoTextual, :string=>akoTextual, :AbstractString=>akoTextual,
    :img=>akoImage, :image=>akoImage, :form=>akoForm, :table=>akoTable, :ol=>akoListed, :ul=>akoListed,
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

@enum AkoContext begin
    noContext=1 akoBackground akoForeground 
    akoEntry akoSequence akoTabular akoHierarchy
    akoColor akoFont akoWord akoText
    akoBorder akoMargin akoPadding
    akoBox akoColumn akoGrid akoFlex 
    akoOutline akoTransform
end

const akoContext = Dict(:nothing=>noContext, :Nothing=>noContext,
    :body=>akoHierarchy, :head=>akoHierarchy,
    :table=>akoTabular, :ol=>akoSequence, :ul=>akoSequence, :form=>akoEntry,
    # https://www.w3.org/TR/css-color/
    # https://www.w3.org/TR/css-color-adjust-1/
    # https://www.w3.org/TR/css-color-4/
    :color=>akoColor, Symbol("alpha-value")=>akoColor, Symbol("rendering-intent")=>akoColor,
    :lab=>akoColor, :lch=>akoColor, :hwb=>akoColor, :hsl=>akoColor, :rgb=>akoColor, :hue=>akoColor,
    # https://www.w3.org/TR/css-text/
    Symbol("font-family")=>akoFont, Symbol("font-size")=>akoFont, Symbol("font-weight")=>akoFont,
    Symbol("font-variant")=>akoFont, Symbol("font-kerning")=>akoFont, Symbol("font-stretch")=>akoFont,
    Symbol("font-size-adjust")=>akoFont, Symbol("line-height")=>akoFont, Symbol("letter-spacing")=>akoFont,
    Symbol("full-size")=>akoFont, :small=>akoFont, Symbol("full-width")=>akoFont,
    # https://www.w3.org/TR/css-text/
    Symbol("text")=>akoText, Symbol("text-transform")=>akoText, Symbol("text-indent")=>akoText,
    Symbol("hanging-punctuation")=>akoText, Symbol("white-space")=>akoText,
    Symbol("tab-size")=>akoText, Symbol("line-break")=>akoText, :hyphens=>akoText,
    Symbol("overflow-wrap")=>akoText, Symbol("text-align")=>akoText,
    Symbol("text-align-all")=>akoText, Symbol("text-align-last")=>akoText, Symbol("text-justify")=>akoText,
    Symbol("text-justify-all")=>akoText, Symbol("inter-character")=>akoText, 
    # https://www.w3.org/TR/css-text-decor-3/
    #
    :word=>akoWord, Symbol("word-break")=>akoWord, Symbol("word-spacing")=>akoWord,  Symbol("word-wrap")=>akoWord,
    Symbol("keep-all")=>akoWord,  Symbol("inter-word")=>akoText,
    # https://www.w3.org/TR/css-lists-3/
    :outline=>akoOutline,
    :padding=>akoPadding, :margin=>akoMargin, :border=>akoBorder,
    :box=>akoBox, :column=>akoColumn, :grid=>akoGrid, :flex=>akoFlex,
    # https://www.w3.org/TR/css-images-3/
    :transform=>akoTransform
    # https://www.w3.org/TR/css-contain-1/ "This CSS module describes the contain property, which indicates that the element’s subtree is independent of the rest of the page."
    # https://www.w3.org/TR/css-contain-2/ 
    # https://www.w3.org/TR/css-values-3/
    # https://www.w3.org/TR/css-sizing-3/ "This module extends the CSS sizing properties with keywords that represent content-based "intrinsic" sizes and context-based "extrinsic" sizes, allowing CSS to more easily describe boxes that fit their content or fit into a particular layout context."
    )

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
