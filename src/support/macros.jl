"""
    @sym("x") --> :x
    @sym(x) --> Symbol(<value of x>)
"""
macro sym(x)
    esc(:(Symbol($x)))
end

"""
    @maybe(T) --> Union{Nothing, T}
    @maybe(T1,T2) --> Union{Nothing, T1, T2}
"""
macro maybe(T)
    :(Union{Nothing, $T})
end

macro maybe(T1, T2)
    :(Union{Nothing, $T1, $T2})
end
