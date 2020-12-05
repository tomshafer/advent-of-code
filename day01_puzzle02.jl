
include("day01_puzzle01.jl")

function day01_puzzle02(input::String)
    inputs = parse.(Int, readlines(input))
    sort!(inputs, by=x -> abs(2020 ÷ 3 - x))
    for (i, val) in enumerate(inputs)
        match = find_pair_summing_to_value(inputs[(i + 1):end], 2020 - val)
        if !isnothing(match)
            triple = (val, match...)
            println("Entries: $triple")
            println("Product: $(prod(triple))")
            break
        end
    end
end

# day01_puzzle02("day02_input.txt")
