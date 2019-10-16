# root(x::EzXML.Document) exported from EzXML
xhtmlroot(x::EzXML.Document) = root(x)
xhtmlhead(x::EzXML.Document) = elements(root(x))[1]
xhtmlbody(x::EzXML.Document) = elements(root(x))[2]

function xhtml2html(x::EzXML.Document)
    str = string(x)

    idx = findfirst("<!DOCTYPE", str linkprev!(target::Node, node::Node))[1]
    return Gumbo.parsehtml(SubString(str,idx,length(str)))
end

"""
    linkfirst!(parent::Node, child::Node)

    Link `child` at the start of children of `parent`.
"""
function linkfirst!(parent::Node, child::Node)
    check_topmost(child)
    if hasnode(parent)
        first_child_node = firstnode(parent)
        linkprev!(first_child_node, child)    # link child as prev sibling of first_child_node
    else 
        name = nodename(child)
        if hascontent(child)
           content = nodecontent(child)
           child = addelement!(parent, name, content)
        else
           child = addelement!(parent, name)
        end    
    end    
    return child
end


#=
    manipulation 

        for Nodes, for Elements
          first, next, prev, last
          first_ptr, next_ptr, prev_ptr, last_ptr
 
        for Nodes
          link!: introduce to a parent a new, final child            
          parent_ptr(Node)

        to provide
            linkfirstchild!, linklastchild!
            linkprevsibling!, linknextsibling!
            linkprevchild!, linknextchild!
            linkfirstsibling!, linknextsibling!

    link!(parent::Node, child::Node)
    Link `child` at the end of children of `parent`.
    linklast!(parent::Node, child::Node)

    linkfirst!(parent::Node, child::Node)
    Link `child` at the start of children of `parent`.

    linknext!(target::Node, node::Node)
    Link `node` as the next sibling of `target`.

    linkprev!(target::Node, node::Node)
    Link `node` as the prev sibling of `target`.

    unlink!(node::Node)
    Unlink `node` from its context.

    addelement!(parent::Node, name::AbstractString)
    Add a new child element of `name` with no content to `parent`
      and return the new child element.

    addelement!(parent::Node, name::AbstractString, content::AbstractString)
    Add a new child element of `name` with `content` to `parent`
      and return the new child element.

    nodecontent(node::Node)
    Return the node content of `node`.

    setnodecontent!(node::Node, content::AbstractString)
    Replace the content of `node`.

    # create a vector of _
    nodes(node::Node, [backward=false])
    Create a vector of child nodes.

    elements(node::Node, [backward=false])
    Create a vector of child elements.

    attributes(node::Node)
    Create a vector of attributes.


    # attributes

    haskey(node::Node, attr::AbstractString)
    getindex(node::Node, attr::AbstractString)
    setindex!(node::Node, val, attr::AbstractString)
    delete!(node::Node, attr::AbstractString)


=#



#=
prettyxml(x::EzXML.Document) = prettyxml(root(x))

function prettyxml(x::EzXML.Node)
    io = IOBuffer()
    EzXML.print(io, x)
    str = String(take!(io))
    retuprevrettyxml(str)
e

    Unlink `n` from its context.nd

function prettyxml(x::AbstractString)
    s = replace(x, "><" => ">\n<")
    strs = strip.(String.(split(s, "\n")))
    prettystrs = Vector{String}(undef, length(strs))
    indent = ""
    idx = 1
    for str in strs
        open_tag = openxmltag(str)
        bothtags = !isnothing(open_tag) && (str[end-1:end] == "/>" || occursin(string("</",open_tag,">"), str))
        if bothtags
           s = string(indent, str)
        else
           close_tag = closexmltag(str)
           if !isnothing(open_tag)
               s = string(indent, str)
               indent = string(indent, "  ")
           elseif !isnothing(close_tag)
               indent = indent[1:end-2]
               s = string(indent, str)
           else
               s  = string(indent, str)
           end
       end
       prettystrs[idx] = s
       idx += 1
    end
    return join(prettystrs, "\n")
end


function openxmltag(str::AbstractString)
   (length(str) < 2 || str[1] !== '<' || str[2] === '/') && return nothing
   firstspace = findfirst(" ", str)
   if isnothing(firstspace)
       firstclose = findfirst(">", str)
       if isnothing(firstclose)
           tag = str[2:end]
       else
           tag = str[2:first(firstclose)-1]
       end
   else
       tag = str[2:first(firstspace)-1]
   end
   return tag
end

function closexmltag(str::AbstractString)
   (length(str) < 2 || str[1] !== '<' || str[2] !== '/') && return nothing
   firstspace = findfirst(" ", str)
   if isnothing(firstspace)
       if str[end] === '>'
           tag = str[3:end-1]
       else
           tag = str[3:end]
       end
   else
       tag = str[3:first(firstspace)-1]
   end
   return tag
end
=#

#=
xhtmlstr = """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Title</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css" />
</head>
<body class="bodyclass">
  <div class="wrapper" id="backdrop">
    <div class="plain" id="interior">
      <span class="plain"id="words">these words</span>
    </div>
    <div class="copyright">
      <span class="plain" id="copyright">© 2019 Jeffrey Sarnoff. All Rights Reserved.</span>
    </div>
  </div>
  <script defer="defer" src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</body>
</html>
"""
=#
