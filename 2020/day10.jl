
function read_inputs(file::String)
    inputs = parse.(Int, readlines(file))
    sort(append!(copy(inputs), [0, maximum(inputs) + 3]))
end

function day10_puzzle01(file::String)
    inputs = read_inputs(file)
    deltas = [inputs[i] - inputs[i - 1] for i in 2:length(inputs)]
    out = Dict(k => sum(deltas .== k) for k in unique(deltas))
    println("The product is: $(prod(values(out)))")
end

function day10_puzzle02(file::String)
    inputs = read_inputs(file)
    counts = Dict{Int,Int}(0 => 1)
    for i in inputs
        j = unique(clamp.([i - j for j = 1:3], 0, 1_000_000))
        counts[i] = sum(counts[k] for k in j if k in keys(counts))
    end
    println("Number of paths: $(counts[maximum(keys(counts))])")
end

day10_puzzle01("day10_input.txt")
day10_puzzle02("day10_input.txt")
