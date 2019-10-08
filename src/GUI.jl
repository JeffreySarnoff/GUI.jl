module GUI

using DataStructures, LinkedLists, StructArrays, NamedTupleTools
using HTTP, Gumbo, Cascadia, EzXML
using Mustache, Hyperscript
using ReusePatterns

include("type/abstract.jl")            #

include("support/macros.jl")           # @sym
include("type/maybe.jl")               # MaybeString, MaybeFloat, isstring, isfloat ...

include("support/strings.jl")          # isuppercase(String), uppercasefirst

include("support/linkedlist.jl")       # getindex(list, idx::Int)
include("support/dict.jl")             # getkeys::Vector, getvalues::Vector
include("type/prototype.jl")           # specific NamedTuple prototypes

include("support/hyperscript_html.jl") # HTML5 tags
include("support/hyperscript_css.jl")  # CSS3 tags

include("support/gumbo.jl")            # typeofnode(x::HTMLNode)
include("support/cascadia.jl")         #

include("html/template.jl")            #
include("html/elements.jl")            #
include("html/attributes/boolean.jl")  #


end # module GUI
