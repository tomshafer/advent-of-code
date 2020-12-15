
using Printf

function readinput(file::String; dict::Bool=false)
    timestring, busstring = readlines(file)
    buses = [parse(Float64, b) for b in split(busstring, ",") if b ≠ "x"]
    parse(Float64, timestring), buses
end

function day13_puzzle01(file::String)
    time, buses = readinput(file)
    mods = [b - mod(time, b) for b in buses]
    minidx = (mods .== minimum(mods))
    solution = first(buses[minidx]) * first(mods[minidx])
    println("Day 13, Puzzle 1: $(convert(Int, solution))")
end

function readinput2(file::String)
    # Return the (zero-indexed) positions of non-x entries
    _, busstring = readlines(file)
    return [
        (parse(Int, b), i - 1)
        for (i, b) = enumerate(split(busstring, ","))
        if b ≠ "x"
    ]
end

function day13_puzzle02(file::String)
    # For each bus, add multiples of the time so far to get the correct modulo
    buses = reverse(readinput2(file))
    t, increment = 0, 0

    # Initialize with the first bus
    a, m = first(buses)
    t = a - m
    increment = a

    # For the remaining buses,
    for (a, m) in buses[2:end]
        # Lazy way to do this: Run until everything matches up
        m_0 = m ÷ a
        m_1 = mod(m, a)
        for i in 0:(a - 1)
            test = t + i * increment
            if (mod(test, a) == a - m_1) || (m_1 == 0 == mod(test, a))
                t += i * increment
                increment *= a
                break
            end
        end
    end
    println("Day 13, Puzzle 2: $t")
end

day13_puzzle01("day13_input.txt")
day13_puzzle02("day13_input.txt")
