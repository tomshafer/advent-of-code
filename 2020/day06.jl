
function day06_puzzle01(input::String)
    total = 0
    group = Dict{Char,Int}()
    for line in eachline(input)
        if line == ""
            total += length(keys(group))
            group = Dict{Char,Int}()
            continue
        end
        for char in line
            if char in keys(group)
                group[char] += 1
            else
                group[char] = 1
            end
        end
    end
    total += length(keys(group))
    println("Total: $total")
end

function day06_puzzle02(input::String)
    total = people = 0
    group = Dict{Char,Int}()
    for line in eachline("day06_input.txt")
        if line == ""
            total += sum(group[k] == people for k in keys(group))

            group = Dict{Char,Int}()
            people = 0
            continue
        end

        people += 1
        for char in line
            if char in keys(group)
                group[char] += 1
            else
                group[char] = 1
            end
        end
    end
    total += sum(group[k] == people for k in keys(group))
    println("Total: $total")
end

day06_puzzle01("day06_input.txt")
day06_puzzle02("day06_input.txt")
