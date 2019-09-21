"""
    @sym("x") --> :x
    @sym(x) --> Symbol(<value of x>)
"""
macro sym(x)
    esc(:(Symbol($x)))
end
