Base.first(x::Nothing) = nothing
Base.last(x::Nothing)  = nothing
Base.first(x::Missing) = missing
Base.last(x::Missing)  = missing

Base.isless(x::T, y::Nothing) where {T} = false
Base.isless(x::Nothing, y::T) where {T} = true
