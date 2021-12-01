
function day04_puzzle01(input::String)
    required = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
    open("day04_input.txt") do io
        total = 0
        passkeys = Set{String}()
        for line in eachline(io)
            if line == ""
                total += all(x in passkeys for x in required)
                passkeys = Set{String}()
                continue
            end
            matches = eachmatch(r"([a-zA-Z]+)(?=:)", line)
            for m in matches
                push!(passkeys, m.captures...)
            end
        end
        total += all(x in passkeys for x in required)
        println("Total valid passports: $total")
    end
end

function check_valid(input::Dict{String,String})::Int
    required = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
    if any(!in(x, keys(input)) for x in required)
        return 0
    end

    if !(1920 <= parse(Int, input["byr"]) <= 2002)
        return 0
    end
    if !(2010 <= parse(Int, input["iyr"]) <= 2020)
        return 0
    end
    if !(2020 <= parse(Int, input["eyr"]) <= 2030)
        return 0
    end
    if isnothing(match(r"^[0-9]{9}$", input["pid"]))
        return 0
    end
    if isnothing(match(r"^#[0-9a-fA-F]{6}", input["hcl"]))
        return 0
    end
    if !in(input["ecl"], ("amb", "blu", "brn", "gry", "grn", "hzl", "oth"))
        return 0
    end
    if !endswith(input["hgt"], r"in|cm")
        return 0
    end
    if endswith(input["hgt"], "cm") && !(150 <= parse(Int, input["hgt"][1:end - 2]) <= 193)
        return 0
    elseif endswith(input["hgt"], "in") && !(59 <= parse(Int, input["hgt"][1:end - 2]) <= 76)
        return 0
    end
    1
end

function day04_puzzle02(input::String)
    open(input) do io
        total = 0
        passkeys = Dict{String,String}()
        for line in eachline(io)
            if line == ""
                total += check_valid(passkeys)
                passkeys = Dict{String,String}()
                continue
            end
            matches = eachmatch(r"([^\s]+):\s*([^\s]+)", line)
            for m in matches
                k, v = m.captures
                passkeys[k] = v
            end
        end
        total += check_valid(passkeys)
        println("Total valid passports: $total")
    end
end

day04_puzzle01("day04_input.txt")
day04_puzzle02("day04_input.txt")
