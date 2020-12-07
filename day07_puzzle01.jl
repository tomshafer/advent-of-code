
function read_rules(file::String)
    keys = Vector{String}()
    vals = Vector{String}()
    nums = Vector{Int}()
    for line in eachline(file)
        test = match(r"^(.+?) bags contain (.+)\.$", line).captures

        from = popfirst!(test)
        for to in split(pop!(test), ',')
            qty, bagtype = split(strip(to), ' ', limit = 2)
            if qty == "no"
                continue
            end
            push!(keys, from)
            push!(nums, parse(Int, qty))
            push!(vals, replace(bagtype, r"\s+bags?" => ""))
        end
    end

    keys, vals, nums
end

function day07_puzzle01(input::String)
    keys, vals, nums = read_rules(input)
    bagtypes = Vector{String}()
    last = ["shiny gold"]
    while true
        ids = [i for (i,v) in enumerate(vals) if v in last]
        nextval = keys[ids]
        if nextval == []
            break
        end
        append!(bagtypes, nextval)
        last = nextval
    end
    alltypes = Set(bagtypes)
    println("Found $(length(alltypes)) bag types")
end

# day07_puzzle01("day07_input.txt")
