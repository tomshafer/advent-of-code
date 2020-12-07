
include("day07_puzzle01.jl")

function bag_contains(
        bag::String,
        keys::Vector{String},
        vals::Vector{String},
        nums::Vector{Int}
    )::Int

    bags = vals[keys .== bag]
    counts = nums[keys .== bag]

    total = 0
    for (i, b) in enumerate(bags)
        total += counts[i] * (1 + bag_contains(b, keys, vals, nums))
    end
    total
end

function day07_puzzle02(input::String)
    k, v, n = read_rules(input)
    bags = bag_contains("shiny gold", k, v, n)
    print("Our bag contains $bags bags!")
end

# day07_puzzle02("day07_input.txt")
