
function readinput(file::AbstractString)
    matches = match.(r"^([^()]+) \(contains ([^()]+)\)", readlines(file))
    out = Dict()
    allwords = []
    for m in matches
        words, translations = m.captures
        words = strip.(split(words))
        append!(allwords, words)
        translations = strip.(split(translations, ","))
        for t in translations
            if t in keys(out)
                out[t] = intersect(out[t], words)
            else
                out[t] = unique(words)
            end
        end
    end
    out, allwords
end

function day21_puzzle01(file::String)
    inputs, words = readinput(file)
    maps = Dict()
    while length(keys(inputs)) > 0
        for k in sort(collect(keys(inputs)), by=k -> length(inputs[k]))
            # println("$k  $(length(inputs[k]))")
            if length(inputs[k]) == 1
                maps[k] = inputs[k][1]
                for v in values(inputs)
                    deleteat!(v, v .== maps[k])
                end
                delete!(inputs, k)
            end
        end
    end
    otherwords = length([w for w in words if !(w in values(maps))])
    println("Day 21, Puzzle 1: $otherwords")
    maps
end

function day21_puzzle02(maps::Dict)
    soln = join([maps[k] for k in sort(collect(keys(maps)))], ",")
    println("Day 21, Puzzle 2: \"$soln\"")
end

solve = day21_puzzle01("day21_input.txt");
day21_puzzle02(solve)
