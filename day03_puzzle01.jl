
using Printf

function load_input(inp::Array)
    out = reduce(hcat, [[x == '#' ? 1 : 0 for x in r] for r in input])
    out = convert(Array, transpose(out))
    out
end

# x = 1 + <xstep>(y - 1), xmod = 1 + (x - 1) % w
function count_trees(map::Array, xstep::Int = 3, ystep::Int = 1)
    h, w = size(map)
    sum(
        mymap[y, 1 + xstep * (i - 1) % w]
        for (i,y) = enumerate(1:ystep:h)
    )
end

function day03_puzzle01(input::String)
    input = readlines(input)
    mymap = load_input(input)
    println(@sprintf("Trees: %d", count_trees(mymap, 3, 1)))
end

# day03_puzzle01("day03_input.txt")
