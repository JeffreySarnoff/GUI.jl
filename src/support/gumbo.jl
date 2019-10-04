# subtypes(HTMLNode) == [ HTMLElement, HTMLText, NullNode ]

typeofnode(x::HTMLElement{T}) where {T} = T
typeofnode(x::HTMLText) = String
typeofnode(x::NullNode) = Nothing

attributes(x::HTMLElement{T}) where {T} = x.attributes
# attribute_pairs(x::HTMLElement{T}) where {T} = 
attribute_names(x::HTMLElement{T}) where {T}  = keys(attributes(x))
attribute_values(x::HTMLElement{T}) where {T} = values(attributes(x))
