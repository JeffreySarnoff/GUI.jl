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
