#=
Binary (or 0-1) knapsack problem

    Given a knapsack of some capacity C and n objects
       with object i having weight wi and profit pi,
       the goal is to choose some subset of the objects
       that can fit in the knapsack 
       (i.e. the sum of their weights is no more than C)
       while maximizing profit.

    This can be formulated as a mixed-integer program as:
        maximize x' p subject to x∈{0,1}  and  w′x <= C
        x is a vector is size n, where x_i
        is 1 if we chose to keep the object in the knapsack, 
           0 otherwise.

source: https://nbviewer.jupyter.org/github/JuliaOpt/Convex.jl/blob/master/
                                    examples/binary_knapsack.ipynb
=#

# Data taken from http://people.sc.fsu.edu/~jburkardt/datasets/knapsack_01/knapsack_01.html

w = [23; 31; 29; 44; 53; 38; 63; 85; 89; 82]
C = 165 
p =  [92; 57; 49; 68; 60; 43; 67; 84; 87; 72];
n = length(w)

using Convex, GLPKMathProgInterface
x = Variable(n, :Bin)
problem = maximize(dot(p, x), dot(w, x) <= C)
solve!(problem, GLPKSolverMIP())
