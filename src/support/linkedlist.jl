# additional functions for use with LinkedLists.jl

function Base.getindex(lst::SLinkedList, idx::Int)
    !(0 < idx <= length(lst)) && throw(BoundsError("index $idx"))
    return lst[positiontoindex(idx, lst)]
end

function Base.getindex(lst::LinkedList, idx::Int)
    !(0 < idx <= length(lst)) && throw(BoundsError("index $idx"))
    return lst[positiontoindex(idx, lst)]
end
