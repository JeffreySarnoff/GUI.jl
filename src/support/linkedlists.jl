# additional functions for use with LinkedLists.jl

function Base.getindex(lst::LinkedLists.SLinkedList, idx::Int)
    !(0 < idx <= length(lst)) && throw(BoundsError("index $idx"))
    return lst[positiontoindex(idx, lst)]
end

function Base.getindex(lst::LinkedLists.LinkedList, idx::Int)
    !(0 < idx <= length(lst)) && throw(BoundsError("index $idx"))
    return lst[positiontoindex(idx, lst)]
end
