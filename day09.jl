
function pairsums(input::Vector{Int})
    n = size(input)[1]
    out = Set{Int}()
    for (i, elem1) in enumerate(input)
        for elem2 in input[i + 1:end]
            push!(out, elem1 + elem2)
        end
    end
    out
end

function find_mismatches(input::Array{Int}, p::Int)
    out = Vector{Int}()
    for j in (p + 1):length(input)
        !(input[j] in pairsums(input[j - p:j - 1])) && push!(out, input[j])
    end
    out
end

function day09_puzzle01(file::String)
    nums = parse.(Int, readlines(file))
    miss = popfirst!(find_mismatches(nums, 25))
    println("Answer: $miss")
end

function contiguous(input::Array{Int}, size::Int)
    [sum(input[i:i + size]) for i in 1:(length(input) - size)]
end

function day09_puzzle02(file::String)
    nums = parse.(Int, readlines(file))
    miss = popfirst!(find_mismatches(nums, 25))
    for i in 1:length(nums)
        sums = contiguous(nums, i)
        for (j, val) in enumerate(sums)
            if val == miss
                subset = nums[j:j - 1 + i]
                key = minimum(subset) + maximum(subset)
                println("Found match! Size = $i  Index = $j  Answer = $key")
                return
            end
        end
    end
end

day09_puzzle01("day09_input.txt")
day09_puzzle02("day09_input.txt")
