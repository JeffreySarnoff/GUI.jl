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
    first_child!(parent::Node, child::Node)

    Link `child` as the first of the children of `parent`.
"""
function first_child!(parent::EzXML.Node, child::EzXML.Node)
    EzXML.check_topmost(child)
    if EzXML.hasnode(parent)
        first_child_node = EzXML.firstnode(parent)
        EzXML.linkprev!(first_child_node, child)    # link child as prev sibling of first_child_node
    else 
        name = EzXML.nodename(child)
        if EzXML.hascontent(child)
           content = EzXML.nodecontent(child)
           new_child = EzXML.addelement!(parent, name, content)
        else
           new_child = EzXML.addelement!(parent, name)
        end
        for a in EzXML.eachattribute(child)
            EzXML.linknext!(new_child, a)
        end
        child = new_child
    end    
    return child
end

"""
     last_child!(parent::Node, child::Node)

     Link `child` as the last of the children of `parent`.
"""
last_child!(parent::EzXML.Node, child::EzXML.Node) = EzXML.link!(parent, child)


"""
    next_child!(curr_node, next_child)

    Link `next_child` as the child that follows the parent-level `curr_node`.
"""
function next_child!(curr_node::EzXML.Node, next_child::EzXML.Node)
    if EzXML.hasnode(curr_node) # has a child node
        first_child = EzXML.firstnode(curr_node)    
        prev_sibling!(first_child, next_child)
    else
        name = EzXML.nodename(next_child)
        if EzXML.hascontent(next_child)
           content = EzXML.nodecontent(next_child)
           new_child = EzXML.addelement!(curr_node, name, content)
        else
           new_child = EzXML.addelement!(curr_node, name)
        end    
        for a in EzXML.eachattribute(child)
            EzXML.linknext!(new_child, a)
        end
        next_child = new_child
    end            
    return next_child
end

"""
    prev_child!(curr_node, prev_child)

    Link `prev_child` as the child that preceeds the parent-level `curr_node`.
"""
function prev_child!(curr_node::EzXML.Node, prev_child::EzXML.Node)
    if EzXML.hasprevnode(curr_node)
        curr_node = EzXML.prevnode(curr_node)
        if EzXML.hasnode(curr_node)
            last_sibling!(EzXML.lastnode(curr_node), prev_child)
        else
            throw(ErrorException("no previous parent node"))
        end
    else   
        throw(ErrorException("no previous parent node"))
    end    
    return prev_child
end

"""
    next_sibling!(curr_sibling, next_sibling)

    Link `next_sibling` as the next sibling of `curr_sibling`.
"""
next_sibling!(curr_sibling::EzXML.Node, next_sibling::EzXML.Node) = linknext!(curr_sibling, next_sibling)

"""
    prev_sibling!(curr_sibling, prev_sibling)

    Link `prev_sibling` as the prev sibling of `curr_sibling`.
"""
prev_sibling!(curr_sibling::EzXML.Node, prev_sibling::EzXML.Node) = linkprev!(curr_sibling, prev_sibling)

"""
    first_sibling!(curr_sibling::EzXML.Node, first_sibling::EzXML.Node)

    Link `first_sibling` as the first sibling of the siblings to which `curr_sibling` belongs.
"""
function first_sibling!(curr_sibling::EzXML.Node, first_sibling::EzXML.Node)
    initial_sibling_node = EzXML.firstnode(parent(curr_sibling))
    EzXML.linkprev!(initial_sibling_node, first_sibling)    # link first_sibling as prev sibling of initial_sibling_node
    return first_sibling
end

"""
    last_sibling!(curr_sibling::EzXML.Node, last_sibling::EzXML.Node)

    Link `last_sibling` as the last sibling of the siblings to which `curr_sibling` belongs.
"""
function last_sibling!(curr_sibling::EzXML.Node, last_sibling::EzXML.Node)
    final_sibling_node = EzXML.lastnode(parent(curr_sibling))
    EzXML.linknext!(final_sibling_node, last_sibling)    # link last_sibling as next sibling of final_sibling_node
    return last_sibling
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
