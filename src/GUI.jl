module GUI

using LinkedLists, StructArrays, NamedTupleTools
using HTTP, Gumbo, Cascadia
using Hyperscript
using ReusePatterns

include("type/abstract.jl")            #

include("support/macros.jl")           # @sym
include("type/maybe.jl")               # MaybeString, MaybeFloat, isstring, isfloat ...

include("support/linkedlist.jl")       # getindex(list, idx::Int)

include("support/dict.jl")             # getkeys::Vector, getvalues::Vector
include("support/gumbo.jl")            # typeofnode(x::HTMLNode)
include("support/cascadia.jl")         #

include("support/hyperscript_html.jl") # HTML5 tags
include("support/hyperscript_css.jl")  # CSS3 tags

end # module GUI
