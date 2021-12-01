
function find_pair_summing_to_value(arr::Vector{Int}, value::Int=2020)
    arr = sort(arr, by=x -> abs(value ÷ 2 - x))
    # Check all later entries for a match
    for (i, entry) in enumerate(arr)
        subinput = arr[(i + 1):end]
        tests = subinput .== (value - entry)
        if any(tests)
            match = pop!(subinput[tests])
            return (entry, match)
        end
    end
end

function day01_puzzle01(input::String)
    inputs = parse.(Int, readlines(input))
    x = find_pair_summing_to_value(inputs, 2020)
    println("Inputs: $x")
    println("Product: $(prod(x))")
end

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

day01_puzzle01("day01_input.txt")
day01_puzzle02("day01_input.txt")
