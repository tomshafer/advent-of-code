
function readinput(file::AbstractString)
    lines = readlines(file)
    plines = (length(lines) - 3) ÷ 2
    player1 = parse.(Int, lines[2:2 + plines - 1])
    player2 = parse.(Int, lines[2 + plines + 2:2 + 2 * plines + 1])
    player1,  player2
end

function roundwinner(p1::Array{Int}, p2::Array{Int})
    first(p1) > first(p2) ? 1 : 2
end

function countscore(a::Array)
    length(a) == 0 && return 0
    sum((length(a) + 1 - i) * v for (i, v) in enumerate(a))
end

function day22_puzzle01(file::AbstractString)
    p1, p2 = readinput(file)

    while length(p1) > 0 && length(p2) > 0
        winner = roundwinner(p1, p2)
        c1 = popfirst!(p1)
        c2 = popfirst!(p2)
        (winner == 1) && (append!(p1, [c1, c2]))
        (winner == 2) && (append!(p2, [c2, c1]))
    end
    countscore(p1), countscore(p2)
end

function recursivewinner(p1::Array{Int}, p2::Array{Int})
    c1 = first(p1)
    c2 = first(p2)
    if (length(p1) ≥ c1 + 1) && (length(p2) ≥ c2 + 1)
        combat = play_recursivecombat(p1[2:2 + c1 - 1], p2[2:2 + c2 - 1])
        return combat[1] > 0 ? 1 : 2
    end
    return c1 > c2 ? 1 : 2
end

function play_recursivecombat(p1::Array{Int}, p2::Array{Int})
    p1 = copy(p1)
    p2 = copy(p2)
    rounds = Set{UInt64}([])
    while length(p1) > 0 && length(p2) > 0
        thisround = hash([p1, p2])
        thisround in rounds && (winner = 1; p2 = Array{Int}([]); break)
        union!(rounds, thisround)
        winner = recursivewinner(p1, p2)
        c1 = popfirst!(p1)
        c2 = popfirst!(p2)
        (winner == 1) && (append!(p1, [c1, c2]))
        (winner == 2) && (append!(p2, [c2, c1]))
    end
    countscore(p1), countscore(p2)
end

function day22_puzzle02(file::AbstractString)
    p1, p2 = readinput(file)
    play_recursivecombat(p1, p2)
end

# day22_puzzle01("day22_input.txt")
day22_puzzle02("day22_input.txt")





# function day22_puzzle02(file::AbstractString)
#     p1, p2 = readinput(file)

#     rounds = []
#     while length(p1) > 0 && length(p2) > 0

#         value = [copy(p1), copy(p2)]
#         if value in rounds
#             p2 = []
#             break
#         end
#         push!(rounds, value)

#         winner = roundwinner(p1, p2)
#         c1 = first(p1)
#         c2 = first(p2)
#         (winner == 1) && (append!(p1[2:end], [c1, c2]))
#         (winner == 2) && (append!(p2[2:end], [c2, c1]))
#     end
#     countscore(p1), countscore(p2)
# end

# day22_puzzle01("day22_input.txt")




# function play_combat(p1::Array{Int}, p2::Array{Int})
#     p1 = copy(p1)
#     p2 = copy(p2)
#     while length(p1) > 0 && length(p2) > 0
#         c1 = popfirst!(p1)
#         c2 = popfirst!(p2)
#         (c1 > c2) && (append!(p1, [c1, c2]))
#         (c1 < c2) && (append!(p2, [c2, c1]))
#     end
#     p1, p2
# end


# function findwinner(p1::Array, p2::Array)
#     c1 = first(p1)
#     c2 = first(p2)
#     if (c1 ≤ (length(p1) - 1) && c2 ≤ (length(p2) - 1))
#         outcome = play_combat_recursive(p1[2:2 - 1 + c1]::Array{Int}, p2[2:2 - 1 + c2]::Array{Int})
#         return length(outcome[1]) == 0 ? 2 : 1
#     end
#     return c1 > c2 ? 1 : 2
# end


# function play_combat_recursive(p1::Array, p2::Array)
#     p1 = copy(p1)
#     p2 = copy(p2)
#     rounds = []
#     ir = 0
#     global games += 1
#     mygame = copy(games)
#     # println("START GAME $games")
#     while length(p1) > 0 && length(p2) > 0
#         ir += 1
#         # println("Round $ir  ", length(p1), "   ", length(p2))
#         thisround = (copy(p1), copy(p2))
#         if thisround in rounds
#             return (p1, [])
#         end
#         push!(rounds, thisround)
#         winner = findwinner(p1, p2)
#         c1 = popfirst!(p1)
#         c2 = popfirst!(p2)
#         (winner == 1) && (append!(p1, [c1, c2]))
#         (winner == 2) && (append!(p2, [c2, c1]))
#         # sleep(0.1)
#     end
#     # println("END GAME $mygame")
#     p1, p2
# end

# games = 0
# p1, p2 = readinput("day22_input.txt");
# x = play_combat_recursive(p1, p2)

# sum([(length(x[1]) - i + 1) * v for (i, v) in enumerate(x[1])])
# sum([(length(x[2]) - i + 1) * v for (i, v) in enumerate(x[2])])

# y = [7, 5, 6, 2, 4, 1, 10, 8, 9, 3]

# # 7130 too low
# # 33842 too high

# # sum(j => [(length(p1)-i+1)*k for (i,k) in enumerate(l)] for (j,l) in enumerate(play_combat(p1, p2)))



# # println(p1)
# # println(p2)
# # println()
