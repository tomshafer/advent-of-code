
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

# day06_puzzle01("day06_input.txt")
