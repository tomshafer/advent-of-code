
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
end

day06_puzzle02("day06_input.txt")
