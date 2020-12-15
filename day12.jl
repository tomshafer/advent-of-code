
function read_line(l::String)
    direction = l[1]
    distance = parse(Float64, l[2:end])
    direction, distance
end

function set_location_heading(
        loc::Array, head::Array, dir::Char, dist::Float64;
        which="loc"
    )
    DMAP = Dict(
        'N' => [ 0,  1],
        'S' => [ 0, -1],
        'E' => [ 1,  0],
        'W' => [-1,  0]
    )
    if dir == 'F'
        loc += head * dist
    elseif dir in "NSEW"
        if which == "loc"
            loc += DMAP[dir] * dist
        else
            head += DMAP[dir] * dist
        end
    elseif dir in "LR"
        r = sqrt(sum(head.^2))
        x, y = head
        t = atan(y, x) + (-1)^(dir == 'R') * π * dist / 180
        head = r .* [cos(t), sin(t)]
    end
    loc, head
end

function day12_puzzle01(file::String)
    location = [0.0, 0.0]
    heading  = [1.0, 0.0]
    for line in eachline(file)
        dir, dist = read_line(line)
        location, heading = set_location_heading(location, heading, dir, dist)
    end
    println(sum(abs.(location)))
end

function day12_puzzle02(file::String)
    location = [0.0, 0.0]
    heading  = [10.0, 1.0]
    for line in eachline(file)
        dir, dist = read_line(line)
        location, heading = set_location_heading(
            location,
            heading,
            dir,
            dist,
            which="head"
        )
    end
    println(sum(abs.(location)))
end

day12_puzzle01("day12_input.txt")
day12_puzzle02("day12_input.txt")
