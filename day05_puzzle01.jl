
# These are both bit representations, inverted
function frontback(fb::String)::Int
    sum(2 .^ (7 .- map(x -> x.start, findall(r"B", fb[1 : end-3]))))
end

function leftright(lr::String)::Int
    sum(2 .^ (3 .- map(x -> x.start, findall(r"R", lr[end-2 : end]))))
end

function day05_puzzle01(input::String)
    passes = readlines(input)
    max_id = maximum(frontback.(passes) .* 8 + leftright.(passes))

    println("Maximum pass ID: $max_id")
end

# day05_puzzle01("day05_input.txt")
