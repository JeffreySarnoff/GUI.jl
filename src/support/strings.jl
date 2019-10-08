splitstring(str::AbstractString, at::Union{Char,AbstractString}) = String.(split(str, at))

function Base.Unicode.isuppercase(s::AbstractString)
    result = true
    for ch in s
      if !isuppercase(ch)
          result = false
          break
      end
    end
    return result
end

function uppercasefirst(x::AbstractString)
    s = strip(x)
    return if isempty(s) || isuppercase(x)
               s
           else    
               string(uppercase(x[1]), x[2:end])
           end
end
