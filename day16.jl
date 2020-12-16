
function readinput(file::String)
    labels = []
    ranges = []
    ticket = []
    examples = []
    let lines = readlines(file)
        # Rules
        while true
            line = popfirst!(lines)
            line == "" && break
            push!(labels, pop!(match(r"^([^:]+)", line).captures))
            caps = parse.(Int, match(r"(\d+)-(\d+).*?(\d+)-(\d+)", line).captures)
            push!(ranges, [caps[i]:caps[i + 1] for i in 1:2:length(caps)])
        end
        # Ticket
        popfirst!(lines)
        ticket = parse.(Int, split(popfirst!(lines), ','))
        popfirst!(lines)
        # Nearby tickets
        popfirst!(lines)
        examples = [
            parse.(Int, split(line, ','))
            for line in lines
        ]
    end
    labels, ranges, ticket, examples
end

function day16_puzzle01(file::String)
    # Precompute the possible values
    _, ranges, _, nearby = readinput(file)
    combined = Set(union([union(j...) for j in ranges]...))

    rate = 0
    for example in nearby
        for entry in example
            !(entry in combined) && (rate += entry)
        end
    end
    println("Day 16, Puzzle 1: $rate")
end

function day16_puzzle02(file::String)
    labels, ranges, ticket, nearby = readinput(file)
    combined = Set(union([union(j...) for j in ranges]...))

    # Drop invalid tickets
    nearby = [n for n in nearby if all(j in combined for j in n)]

    # Find which fields each can be by looking per-column
    stacked = permutedims(hcat(nearby...))

    matches = [
        [
            all(in.(stacked[:,icol], Ref(Set(union(r...)))))
            for r in ranges
        ]
        for icol in 1:size(stacked, 2)
    ]

    # sorted by number of possibilities
    smatches = sort([(sum(x), i) for (i, x) in enumerate(matches)])

    # assignments
    assigns = Dict()
    assigned = Set()
    for (_, icol) in smatches
        candidates = findall(x -> x == 1, matches[icol])
        setdiff!(candidates, assigned)
        found = popfirst!(candidates)
        assigns[icol] = labels[found]
        push!(assigned, found)
    end

    out = prod(ticket[[k for (k, v) in assigns if startswith(v, "departure")]])
    println("Day 16, Puzzle 2: $out")
end

day16_puzzle01("day16_input.txt")
day16_puzzle02("day16_input.txt")
