
function readinput(file::String)
    parse.(Int, split(readline(file), ','))
end

function runloop(input::Vector{Int}, toint::Int)
    tracker = Dict{Int,Int}(v => i for (i, v) in enumerate(input[1:end - 1]))
    lastval = last(input)
    for i in (length(input) + 1):toint
        if !(lastval in keys(tracker))
            tracker[lastval] = i - 1
            lastval = 0
        else
            new_lastval = i - 1 - tracker[lastval]
            tracker[lastval] = i - 1
            lastval = new_lastval
        end
    end
    lastval
end

function day15_puzzle01(file::String)
    input = readinput(file)
    println("Day 15, Puzzle 1: $(runloop(input, 2020))")
end

function day15_puzzle02(file::String)
    input = readinput(file)
    println("Day 15, Puzzle 2: $(runloop(input, 30_000_000))")
end

day15_puzzle01("day15_input.txt")
day15_puzzle02("day15_input.txt")
