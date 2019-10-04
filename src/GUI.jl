module GUI

using LinkedLists
using Hyperscript
using ReusePatterns

include("support/macros.jl")     # @sym
include("support/linkedlist.jl") # getindex(list, idx::Int)
include("type/maybe.jl")         # Maybe{Int,Float,Number,String,Symbol}, is{int,float,number,string,symbol}

include("support/gumbo.jl")      # typeofnode(x::HTMLNode)
include("support/cascadia.jl")   #

include("support/hyperscript_html.jl") # HTML5 tags
include("support/hyperscript_css.jl")  # CSS3 tags

end # module GUI
