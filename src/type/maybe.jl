const MaybeInt    = Union{Nothing, Int}
const MaybeFloat  = Union{Nothing, Float64}
const MaybeSymbol = Union{Nothing, Symbol}
const MaybeString = Union{Nothing, String}
const MaybeNumber = Union{Nothing, Int, Float64}

isint(x::MaybeInt)       = !isnothing(x)
isfloat(x::MaybeFloat)   = !isnothing(x)
issymbol(x::MaybeSymbol) = !isnothing(x)
isstring(x::MaybeString) = !isnothing(x)
isnumber(x::MaybeNumber) = !isnothing(x)

isint(x::Int)        = true
isfloat(x::Float64)  = true
issymbol(x::Symbol)  = true
isstring(x::String)  = true
isnumber(x::Int)     = true
isnumber(x::Float64) = true

isint(x)    = false
isfloat(x)  = false
issymbol(x) = false
isstring(x) = false
isnumber(x) = false

