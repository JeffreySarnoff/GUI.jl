# extend `nothing` to passthrough `first`,`last`, and allied
Base.iterate(x::Nothing) = nothing
Base.firstindex(x::Nothing) = nothing
Base.lastindex(x::Nothing) = nothing
Base.getindex(collection::Nothing, key::Any) = nothing
Base.getindex(collection::Any, key::Nothing) = nothing
Base.first(x::Nothing) = nothing
Base.last(x::Nothing) = nothing

