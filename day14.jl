
function bitstoint(bits::Array{Int})
    sum(b * 2^(i - 1) for (i, b) in enumerate(reverse(bits)))
end

function day14_puzzle01(file::String)
    mem = Dict{Int,Int}()
    mask = repeat('X', 36)

    for line in readlines(file)
        if startswith(line, "mask")
            global mask = replace(line, r"^mask = " => "")
            global bitmask = [i for (i, m) = enumerate(mask) if m ≠ 'X']
            global modified_vals = [parse(Int, x) for x in mask[bitmask]]
            continue
        end
        position, value = map(
            x -> parse(Int, x),
            match(r"mem\[([0-9]+)\] = (\d+)", line).captures
        )

        bitvalue = reverse(digits(value, base=2, pad=36))
        bitvalue[bitmask] = modified_vals
        mem[position] = bitstoint(bitvalue)
    end
    println("Day 14, Puzzle 1: $(sum(values(mem)))")
end

function day14_puzzle02(file::String)
    mem = Dict{Int,Int}()
    mask = repeat('X', 36)

    for line in readlines(file)
        if startswith(line, "mask")
            global mask = replace(line, r"^mask = " => "")
            global bitmask_x = [i for (i, m) = enumerate(mask) if m == 'X']
            global bitmask_o = [i for (i, m) = enumerate(mask) if m == '1']
            global masked_vals = [parse(Int, x) for x in mask[bitmask_o]]
            continue
        end

        position, value = map(
            x -> parse(Int, x),
            match(r"mem\[([0-9]+)\] = (\d+)", line).captures
        )

        # Get new, masked key
        bitposition = reverse(digits(position, base=2, pad=36))
        bitposition[bitmask_o] = masked_vals

        # No combinatorics if no X's
        if length(bitmask_x) == 0
            mem[bitstoint(bitposition)] = value
            continue
        end

        # Combinatorics
        xprods = cat(Iterators.product([[0, 1] for x in bitmask_x]...)..., dims=1)
        for r in xprods
            bitposition[bitmask_x] = [i for i in r]
            mem[bitstoint(bitposition)] = value
        end
    end
    println("Day 14, Puzzle 2: $(sum(values(mem)))")
end


day14_puzzle01("day14_input.txt")
day14_puzzle02("day14_input.txt")
