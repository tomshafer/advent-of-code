
function destcup(cup::Int, values::Array{Int}, maxsize::Int)
    for i in 1:maxsize
        test = 1 + mod(cup - i - 1, maxsize)
        !(test in values) && return test
    end
    return Inf
end

readinput(file::AbstractString) = parse.(Int, split(readline(file), ""))

function day23_puzzle01(file::AbstractString, maxiter::Int=100; log::Bool=false)
    input = readinput(file)
    insize = length(input)
    append!(input, insize+1 : 10)
    insize = length(input)
    iterations = []
    for iter in 1:maxiter
        key = popfirst!(input)
        trio = splice!(input, 1:3)
        for step in 1:insize
            trial = key - step
            trial < 0 && (trial = 1 + mod(trial, insize))
            !(trial in input) && continue
            idx = findfirst(x -> x == trial, input)
            splice!(input, idx + 1:idx, trio)
            push!(input, key)
            id2 = findfirst(x -> x == 1, input)
            id2_1 = 1+mod(id2+1-1,insize)
            id2_2 = 1+mod(id2+2-1,insize)
            println("1  $(input[id2_1])  $(input[id2_2])")
            break
        end
        if input in iterations
            idx = findfirst(x -> x == input, iterations)
            println("First occurrence = $idx")
            println("Repeat at        = $iter")
            println("Frequency        = $(iter - idx)")
            break
        end
        push!(iterations, copy(input))
    end
    println(input)
end

day23_puzzle01("day23_input.txt", 10000, log=true)
