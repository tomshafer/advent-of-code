
include("day03_puzzle01.jl")

function day03_puzzle02(input::String)
    input = readlines(input)
    mymap = load_input(input)

    total = 1
    for (a,b) in ((1,1), (3,1), (5,1), (7,1), (1,2))
        output = count_trees(mymap,a,b)
        total *= output
        println("$a  $b  $output")
    end
    println(@sprintf("Trees: %d", total))
end

# day03_puzzle02("day03_input.txt")
