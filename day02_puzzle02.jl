
include("day02_puzzle01.jl")

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

day02_puzzle02("day02_input.txt")
