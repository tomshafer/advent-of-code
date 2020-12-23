
# Helpers
include("day11.jl")
printmap(mat::Array{AbstractString,2}) = printmap(map(first, mat))
printmap(mat::Array{Int,2}) = printmap(map(x -> first("$x"), mat))

function readinput(file::AbstractString)
    lines = readlines(file)
    out = Dict{Int,Array{AbstractString,2}}()
    for i in 1:12:length(lines)
        id = parse(Int, last(split(strip(lines[i], ':'))))
        out[id] = permutedims(hcat(split.(lines[i + 1:i + 10], "")...))
    end
    out
end

flipv(mat::AbstractArray) = mat[:, end:-1:1]
fliph(mat::AbstractArray) = mat[end:-1:1,:]

function day20_puzzle01(file::AbstractString)
    inputs = readinput(file)
    stored = Dict{Tuple,Tuple}()

    id = first(collect(keys(inputs)))
    stored[(0, 0)] = (id, inputs[id])
    delete!(inputs, id)

    ops1 = (identity, rotl90, rotr90, rot180)
    ops2 = (identity, flipv, fliph)

    iters = 0
    cache = copy(stored)
    while length(keys(inputs)) > 0
        iters += 1
        for (k, (_, mat)) in stored
            # Left
            if !(k .+ (-1, 0) in keys(stored))
                l = unique([(i, o2(o1(m))) for (i, m) in inputs for o1 in ops1 for o2 in ops2 if o2(o1(m))[:, end] == mat[:, 1]])
                println("Left: $(length(l))  $(length(l) > 1 ? "***" : "")")
                if length(l) == 1
                    stored[k .+ (-1, 0)] = l[1]
                    delete!(inputs, l[1][1])
                end
            end
            # Right
            if !(k .+ (1, 0) in keys(stored))
                l = unique([(i, o2(o1(m))) for (i, m) in inputs for o1 in ops1 for o2 in ops2 if o2(o1(m))[:, 1] == mat[:, end]])
                println("Right: $(length(l))  $(length(l) > 1 ? "***" : "")")
                if length(l) == 1
                    stored[k .+ (1, 0)] = l[1]
                    delete!(inputs, l[1][1])
                end
            end
            # Top
            if !(k .+ (0, 1) in keys(stored))
                l = unique([(i, o2(o1(m))) for (i, m) in inputs for o1 in ops1 for o2 in ops2 if o2(o1(m))[end, :] == mat[1, :]])
                println("Top: $(length(l))  $(length(l) > 1 ? "***" : "")")
                if length(l) == 1
                    stored[k .+ (0, 1)] = l[1]
                    delete!(inputs, l[1][1])
                end
            end
            # Bottom
            if !(k .+ (0, -1) in keys(stored))
                l = unique([(i, o2(o1(m))) for (i, m) in inputs for o1 in ops1 for o2 in ops2 if o2(o1(m))[1, :] == mat[end, :]])
                println("Bottom: $(length(l))  $(length(l) > 1 ? "***" : "")")
                if length(l) == 1
                    stored[k .+ (0, -1)] = l[1]
                    delete!(inputs, l[1][1])
                end
            end
        end
        println("Remaining: $(sort(collect(keys(inputs))))")
        stored == cache && break
        cache = copy(stored)
    end

    xmin, xmax = minimum([l[1] for l in keys(stored)]), maximum([l[1] for l in keys(stored)])
    ymin, ymax = minimum([l[2] for l in keys(stored)]), maximum([l[2] for l in keys(stored)])

    p = prod([stored[i][1] for i in collect(Iterators.product([xmin, xmax], [ymin, ymax]))[:,:]])
    println("Day 20, Puzzle1: $p")
    stored
end

function day20_puzzle02(soln::Dict)
    ops1 = (identity, rotl90, rotr90, rot180)
    ops2 = (identity, flipv, fliph)

    picture = Matrix{Int}(undef, 12 * 8, 12 * 8) .= 0

    for (x, y) in keys(soln)
        ix = 1 + (x - (-4)) * 8
        iy = 1 + ((3) - y) * 8
        picture[iy:iy + 7, ix:ix + 7] .= (soln[(x, y)][2][2:9,2:9] .== "#")
    end

    # Seamonster
    monster = [
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
        1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 1 1 1
        0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0
    ]

    mony, monx = size(monster)
    picy, picx = size(picture)
    for o1 in ops1, o2 in ops2
        all = 0
        pic = o1(o2(picture))
        for ix in 1:1:(picx - size(monster, 2) + 1), iy in 1:1:(picy - size(monster, 1) + 1)
            subpic = pic[iy:(iy + mony - 1),ix:(ix + monx - 1)]
            all += ((subpic .& monster) == monster)
        end
        if all > 0
            println("Day 20, Puzzle 2: $(sum(picture) - all * sum(monster))")
        end
    end
end


solve = day20_puzzle01("day20_input.txt");
day20_puzzle02(solve)
