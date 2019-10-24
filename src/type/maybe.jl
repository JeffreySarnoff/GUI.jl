const MaybeSymbol  = Union{Nothing, Symbol
const MaybeString  = Union{Nothing, String}
const MaybeNumber  = Union{Nothing, Int, Float64}
const MaybeInteger = Union{Nothing, Int32, Int64}
const MaybeFloat   = Union{Nothing, Float32, Float64}
const MaybeURI     = Union{Nothing, URI}
const MaybeMIME    = Union{Nothing, MIME}
const MaybeTuple   = Union{Nothing, Tuple}
const MaybeNTuple{N,T} = Union{Nothing, NTuple{N,T}}
const MaybeNamedTuple = Union{Nothing, NamedTuple}


isinteger(x::MaybeInteger) = !isnothing(x)
isfloat(x::MaybeFloat)     = !isnothing(x)
issymbol(x::MaybeSymbol)   = !isnothing(x)
isstring(x::MaybeString)   = !isnothing(x)
isnumber(x::MaybeNumber)   = !isnothing(x)
isuri(x::MaybeURI)         = !isnothing(x)
ismime(x::MaybeMIME)       = !isnothing(x)
istuple(x::MaybeTuple)     = !isnothing(x)
isntuple(x::MaybeNTuple{N,T}) where {N,T} = !isnothing(x)
isnamedtuple(x::MaybeNamedTuple) = !isnothing(x)

isinteger(x::Int32)  = true
isinteger(x::Int64)  = true
isfloat(x::Float32)  = true
isfloat(x::Float64)  = true
issymbol(x::Symbol)  = true
isstring(x::String)  = true
isnumber(x::Int)     = true
isnumber(x::Float64) = true
isuri(x::URI)        = true
ismime(x::MIME)      = true
istuple(x::Tuple)    = true
isntuple(x:NTuple{N,T}) where {N,T} = true
isnamedtuple(x::NamedTuple) = true

isinteger(x) = false
isfloat(x)   = false
issymbol(x)  = false
isstring(x)  = false
isnumber(x)  = false
isuri(x)     = false
ismime(x)    = false
istuple(x)   = false
isntuple(x)  = false
isnamedtuple(x) = false

