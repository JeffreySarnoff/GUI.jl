using Base: KeySet
#=
      keys(::Dict{K,V})::KeySet{Symbol,Dict{Symbol,Any}}   # KeySet for a  Dict{Symbol,Any}
    values(::Dict{K,V})::ValueIterator{Dict{Symbol,Any}}   # ValueIterator for a  Dict{Symbol,Any}
=#

(getkeys(dict::Dict{K,V})::Array{Symbol,1}) where {K,V} = dict.keys[getslotidxs(dict)]

(getvalues(dict::Dict{K,V})::Array{Any,1}) where {K,V}  = dict.vals[getslotidxs(dict)]
     
(getslotidxs(dict::Dict{K,V})::Array{Int, 1}) where {K,V} = filter(i->isone(dict.slots[i]), 1:length(dict.slots))
