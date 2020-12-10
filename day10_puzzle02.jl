
include("day10_puzzle01.jl")

function day10_puzzle02(file::String)
    inputs = read_inputs(file)
    counts = Dict{Int,Int}(0 => 1)
    for i in inputs
        j = unique(clamp.([i - j for j = 1:3], 0, 1_000_000))
        counts[i] = sum(counts[k] for k in j if k in keys(counts))
    end
    println("Number of paths: $(counts[maximum(keys(counts))])")
end

# day10_puzzle02("day10_input.txt")
