module GUI

using LinkedLists

include("support/macros.jl")     # @sym
include("support/linkedlist.jl") # getindex(list, idx::Int)
include("type/maybe.jl")         # Maybe{Int,Float,Number,String,Symbol}, is{int,float,number,string,symbol}

end # module GUI
