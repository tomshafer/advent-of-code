
function readinput(file::String; dims::Int=3)
    grid = Dict{Tuple,Int}()
    for (iy, line) in enumerate(readlines(file))
        for (ix, char) in enumerate(line)
            grid[(ix - 1, iy - 1, [0 for i in 3:dims]...)] = convert(Int, char == '#')
        end
    end
    grid
end

function day17_puzzle01(file::String)
    input = readinput(file)
    new = copy(input)
    for iround in 1:6
        min_coord = [minimum(k[i] for k in keys(input)) for i in 1:3] .- 1
        max_coord = [maximum(k[i] for k in keys(input)) for i in 1:3] .+ 1
        ranges = map(x -> UnitRange(x...), collect(zip(min_coord, max_coord)))
        println("$iround  $min_coord  $max_coord  $ranges")
        for coord in Iterators.product(ranges...)
            deltas = Iterators.product(-1:1, -1:1, -1:1)
            neighbors = 0
            for key in deltas
                key == (0, 0, 0) && continue
                loc = coord .+ key
                if loc in keys(input) && input[loc] == 1
                    neighbors += 1
                end
            end
            if coord in keys(input) && input[coord] == 1
                new[coord] = neighbors in (2, 3) ? 1 : 0
            else
                neighbors == 3 && (new[coord] = 1)
            end
        end
        input = copy(new)
    end
    sum(values(input))
end

function day17_puzzle02(file::String)
    input = readinput(file, dims=4)
    new = copy(input)
    for iround in 1:6
        min_coord = [minimum(k[i] for k in keys(input)) for i in 1:4] .- 1
        max_coord = [maximum(k[i] for k in keys(input)) for i in 1:4] .+ 1
        ranges = map(x -> UnitRange(x...), collect(zip(min_coord, max_coord)))
        println("$iround  $min_coord  $max_coord  $ranges")
        for coord in Iterators.product(ranges...)
            deltas = Iterators.product(-1:1, -1:1, -1:1, -1:1)
            neighbors = 0
            for key in deltas
                key == (0, 0, 0, 0) && continue
                loc = coord .+ key
                if loc in keys(input) && input[loc] == 1
                    neighbors += 1
                end
            end
            if coord in keys(input) && input[coord] == 1
                new[coord] = neighbors in (2, 3) ? 1 : 0
            else
                neighbors == 3 && (new[coord] = 1)
            end
        end
        input = copy(new)
    end
    sum(values(input))
end


day17_puzzle01("day17_input.txt")
day17_puzzle02("day17_input.txt")
