module GUI

using LinkedLists
using Hyperscript

include("support/macros.jl")     # @sym
include("support/linkedlist.jl") # getindex(list, idx::Int)
include("type/maybe.jl")         # Maybe{Int,Float,Number,String,Symbol}, is{int,float,number,string,symbol}

include("support/hyperscript.jl") # HTML5 tags

end # module GUI
