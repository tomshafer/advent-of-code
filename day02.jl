
struct Password
    min::Int; max::Int; char::String; password::String
end

function password_from_capture(c::Array)
    if length(c) != 4 error("X") end
    Password(parse(Int, c[1]), parse(Int, c[2]), c[3], c[4])
end

function extract_passwords(inputs::Array{String})
    rx = r"^(\d+)-(\d+) (\w): (\w+)$"
    [password_from_capture(m.captures) for m in match.(rx, inputs)]
end

count_policy_matches(passwords::Array{Password}) = sum(
    p.min <= count(p.char, p.password) <= p.max
    for p in passwords
)

function day02_puzzle01(filepath::String)
    inputs = readlines(filepath)
    n = count_policy_matches(extract_passwords(inputs))
    println("Passwords: $(length(inputs))")
    println("Matches:   $(n)")
end

count_new_policy_matches(passwords::Array{Password}) = sum(
    (p.password[p.min:p.min] == p.char) ⊻ (p.password[p.max:p.max] == p.char)
    for p in passwords
)

function day02_puzzle02(filepath::String)
    inputs = readlines(filepath)
    n = count_new_policy_matches(extract_passwords(inputs))
    println("Passwords: $(length(inputs))")
    println("Matches:   $(n)")
end

day02_puzzle01("day02_input.txt")
day02_puzzle02("day02_input.txt")
