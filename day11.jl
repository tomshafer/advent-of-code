
function readfile(file::String)
    temp = map(collect, readlines(file))
    rows, cols = size(temp, 1), size(first(temp), 1)
    mat = [temp[i][j] for i = 1:rows, j = 1:cols]
end

function printmap(mat::Array{Char,2})
    let rows = size(mat, 1)
        for r in 1:rows
            println(join(mat[r, 1:end]))
        end
    end
end


function adjseats(mat::Array{Char,2}, m::Int, n::Int)
    rows, cols = size(mat)
    tests = vec(collect(Iterators.product(-1:1, -1:1)))

    total = 0
    for (xshift, yshift) in tests
        (xshift, yshift) == (0, 0) && continue
        i = m + yshift
        j = n + xshift
        (i < 1 || i > rows) && continue
        (j < 1 || j > cols) && continue
        total += mat[i, j] == '#'
    end
    total
end

function day11_puzzle01(file::String)
    mat = readfile(file)
    rows, cols = size(mat)

    new = copy(mat)
    iters = 0
    while true
        iters += 1
        for m = 1:rows, n=1:cols
            occupied = adjseats(mat, m, n)
            (mat[m, n] == 'L' && occupied == 0) && (new[m, n] = '#'; continue)
            (mat[m, n] == '#' && occupied ≥  4) && (new[m, n] = 'L'; continue)
        end
        (new == mat) && break
        mat = copy(new)
    end
    println("Answer: $(sum(mat .== '#'))")
end


function vizseats(mat::Array{Char, 2}, m::Int, n::Int)
    rows, cols = size(mat)
    tests = vec(collect(Iterators.product(-1:1, -1:1)))

    total = 0
    for (xshift, yshift) in tests
        (xshift, yshift) == (0, 0) && continue
        m == 1    && yshift < 0 && continue
        n == 1    && xshift < 0 && continue
        m == rows && yshift > 0 && continue
        n == cols && xshift > 0 && continue

        # y direction
        if yshift != 0
            yseq = m + yshift:yshift:(yshift < 0 ? 1 : rows)
        else
            yseq = repeat([m], rows)
        end

        # x direction
        if xshift != 0
            xseq = n + xshift:xshift:(xshift < 0 ? 1 : cols)
        else
            xseq = repeat([n], cols)
        end

        elems = mat[[CartesianIndex(b,a) for (a,b) = zip(xseq, yseq)]]
        elems = elems[elems .≠ '.']

        (length(elems) == 0) && continue
        (first(elems) == '#') && (total += 1)
    end
    total
end

function day11_puzzle02(file::String)
    mat = readfile(file)
    rows, cols = size(mat)

    new = copy(mat)
    iters = 0
    while true
        iters += 1
        for m = 1:rows, n=1:cols
            occupied = vizseats(mat, m, n)
            (mat[m, n] == 'L' && occupied == 0) && (new[m, n] = '#'; continue)
            (mat[m, n] == '#' && occupied ≥  5) && (new[m, n] = 'L'; continue)
        end
        (new == mat) && break
        mat = copy(new)
    end
    println("Answer: $(sum(mat .== '#'))")
end

# day11_puzzle01("day11_input.txt")
# day11_puzzle02("day11_input.txt")
