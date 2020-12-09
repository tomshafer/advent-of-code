
include("day09_puzzle01.jl")

function contiguous(input::Array{Int}, size::Int)
    [sum(input[i : i + size]) for i in 1:(length(input) - size)]
end

function day09_puzzle02(file::String)
    nums = parse.(Int, readlines(file))
    miss = popfirst!(find_mismatches(nums, 25))
    for i in 1:length(nums)
        sums = contiguous(nums, i)
        for (j, val) in enumerate(sums)
            if val == miss
                subset = nums[j : j - 1 + i]
                key = minimum(subset) + maximum(subset)
                println("Found match! Size = $i  Index = $j  Answer = $key")
                return
            end
        end
    end
end

# day09_puzzle02("day09_input.txt")
