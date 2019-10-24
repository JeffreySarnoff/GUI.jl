"""
    @sym("x") --> :x
    @sym(x) --> Symbol(<value of x>)

@sym("ab","cd") --> :abcd
@sym(:sym,"_") --> :sym_
@sym(:a,:b,:c) --> :abc
"""
macro sym(x)
    esc(:(Symbol($x)))
end

macro sym(x,y)
    esc(:(Symbol($x,$y)))
end

macro sym(x,y,z)
    esc(:(Symbol($x,$y,$z)))
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
