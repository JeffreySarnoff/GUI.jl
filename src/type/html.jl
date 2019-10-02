abstract type AbstractWeb{T} end
abstract type AbstractWebElement{T} <: AbstractWeb{T} end
abstract type AbstractWebAttribute{T} <: AbstractWeb{T} end

abstract type AbstractHtml{T} <: AbstractWeb{T} end
abstract type AbstractHtmlElement{T, V} <: AbstractWebElement{T} end
abstract type AbstractHtmlAttribute{T, V} <: AbstractWebAttribute{T} end

abstract type AbstractXHtml{T} <: AbstractWeb{T} end
abstract type AbstractXHtmlElement{T, V} <: AbstractWebElement{T} end
abstract type AbstractXHtmlAttribute{T, V} <: AbstractWebAttribute{T} end

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

