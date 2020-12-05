
function find_pair_summing_to_value(arr::Array{Int,1}, value::Int=2020)
    arr = sort(arr, by = x -> abs(value ÷ 2 - x))
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

# day01_puzzle01("day01_input.txt")
