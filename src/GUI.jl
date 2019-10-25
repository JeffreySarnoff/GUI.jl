module GUI

export HtmlElement, hyperhtml, Context, Content,
       render

using DataStructures, LinkedLists, StructArrays, NamedTupleTools, AbstractTrees
using CanonicalTraits
using Gumbo, Cascadia, EzXML
using HAML, Mustache, Hyperscript
using ReusePatterns

using HTTP, HTTP.URIs

include("type/abstract.jl")            #

include("support/macros.jl")           # @sym
include("type/maybe.jl")               # MaybeString, MaybeFloat, isstring, isfloat ...

include("support/misc.jl")             # first(nothing), isless(x, nothing) ...
include("support/strings.jl")          # isuppercase(String), uppercasefirst

include("support/linkedlists.jl")      # getindex(list, idx::Int)
include("support/dict.jl")             # getkeys::Vector, getvalues::Vector
include("type/prototype.jl")           # specific NamedTuple prototypes

include("html/hyperscript_html.jl")    # HTML5 tags
#include("css/hyperscript_css.jl")     # CSS3 tags
include("type/algebra.jl")             # Content, Context, HtmlElement

include("support/ezxml.jl")            # prettyxml
include("support/gumbo.jl")            # typeofnode(x::HTMLNode)
include("support/cascadia.jl")         #
include("support/hyperscript.jl")      # convert to Gumbo, push!, pushlast!

include("html/template.jl")            #
include("html/elements.jl")            #
include("html/attributes/boolean.jl")  #
include("html/googlefonts.jl")         # googlefontlink


end # module GUI
