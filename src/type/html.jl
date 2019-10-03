abstract type AbstractWebPage end
abstract type AbstractWebPageAspect{T} <: AbstractWebPage{T} end
abstract type AbstractWebPageRole{T}   <: AbstractWebPage{T} end

struct WebPageAspect{T} <: AbstractWebPageAspect{T}
    tag::Symbol
end
struct WebPageRole{T}   <: AbstractWebPageRole{T}
    tag::Symbol
end

const WebPageAspects = Set([])
const WebPageRoles   = Set([])


@quasiabstract mutable struct HtmlShared <: AbstractWebPage
    tag::Symbol           # tag  === Symbol(name)
    name::String          # name === string(tag)
end

tag(x::HtmlShared)  = x.tag
name(x::HtmlShared) = x.name

function HtmlShared(tag::Symbol)
    name = string(tag)
    return HtmlShared(tag, name)
end
function HtmlShared(name::String)
    tag = @sym(name)
    return HtmlShared{T}(tag, name)
end
function HtmlShared(;tag::Symbol)
    name = string(tag)
    return HtmlShared(tag, name)
end
function HtmlShared(;name::String)
    tag = @sym(name)
    return HtmlShared{T}(tag, name)
end
function HtmlShared(;tag::Symbol, name::String)
    return HtmlShared(tag, name)
end



abstract type AbstractWebPageElement{Aspect, Role} <: AbstractWebPage{T} end

abstract type AbstractWebPageAttribute{T} <: AbstractWebPageElement{T} end
abstract type AbstractWebPageAttributeValue{T} <: AbstractWebPageElement{T} end

abstract type AbstractHtml{T} <: AbstractWebPage{T} end
abstract type AbstractHtmlElement{T, V} <: AbstractWebPageElement{T} end
abstract type AbstractHtmlAttribute{T, V} <: AbstractWebPageAttribute{T} end
abstract type AbstractHtmlAttributeValue{T, V} <: AbstractWebPageAttributeValue{T} end

abstract type AbstractXHtml{T} <: AbstractWebPage{T} end
abstract type AbstractXHtmlElement{T, V} <: AbstractWebPageElement{T} end
abstract type AbstractXHtmlAttribute{T, V} <: AbstractWebPageAttribute{T} end
abstract type AbstractXHtmlAttributeValue{T, V} <: AbstractWebPageAttributeValue{T} end

# AbstractWeb params

struct HtmlAttribute{T} end
struct HtmlAttributeValue{T} end

const  web_boolean_value = WebAttributeValue{Bool}()
const  web_integer_value = WebAttributeValue{Int}()
const  web_float_value = WebAttributeValue{Float64}()
const  web_string_value = WebAttributeValue{String}()

struct HtmlAttribute{V} <: AbstractHtmlAttribute{T, V}
    name::String
    valuation::V
end


abstract type AbstractWebPage{Kind} end
abstract type AbstractWebConstituent{Sort, Kind} end
abstract type AbstractWebElement{Sort}   <: AbstractWebConstituent{Sort, Kind} end
abstract type AbstractWebAttribute{Sort} <: AbstractWebConstituent{Sort, Kind} end
abstract type AbstractWebProperty{Sort}  <: AbstractWebConstituent{Sort, Kind} end
abstract type AbstractWebValuation{Sort} <: AbstractWebConstituent{Sort, Kind} end

# AbstractWebPage Kinds
struct HTML5 end
struct XHTML end

# AbstractWeb Value Constituents
struct BooleanValued end
struct EnumValued end
struct IntegerValued end
struct NonNegativeIntegerValued end
struct PositiveIntegerValued end
struct FloatValued end


abstract type AbstractHTML5{URI} <: AbstractWebPage{HTML5}
abstract type AbstractXHTML{URI} <: AbstractWebPage{XHTML}

