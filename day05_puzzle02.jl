
include("day05_puzzle01.jl")

function day05_puzzle02(input::String)
    passes = readlines(input)
    ids = frontback.(passes) .* 8 + leftright.(passes)
    all = range(minimum(ids), stop = maximum(ids))
    mine = pop!(setdiff(all, ids))
    println("My pass: $mine")
end

# day05_puzzle02("day05_input.txt")
