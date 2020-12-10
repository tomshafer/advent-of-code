
inputs = parse.(Int, readlines("day10_input.txt"))

function read_inputs(file::String)
    inputs = parse.(Int, readlines(file))
    sort(append!(copy(inputs), [0, maximum(inputs) + 3]))
end

function day10_puzzle01(file::String)
    inputs = read_inputs(file)
    deltas = [inputs[i] - inputs[i-1] for i in 2:length(inputs)]
    out = Dict(k => sum(deltas .== k) for k in unique(deltas))
    println("The product is: $(prod(values(out)))")
end

# day10_puzzle01("day10_input.txt")
