
function pairsums(input::Vector{Int})
    n = size(input)[1]
    out = Set{Int}()
    for (i, elem1) in enumerate(input)
        for elem2 in input[i + 1 : end]
            push!(out, elem1 + elem2)
        end
    end
    out
end

function find_mismatches(input::Array{Int}, p::Int)
    out = Vector{Int}()
    for j in (p + 1):length(input)
        !(input[j] in pairsums(input[j - p : j - 1])) && push!(out, input[j])
    end
    out
end

function day09_puzzle01(file::String)
    nums = parse.(Int, readlines(file))
    miss = popfirst!(find_mismatches(nums, 25))
    println("Answer: $miss")
end


# day09_puzzle01("day09_input.txt")
