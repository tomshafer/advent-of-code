
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

# day04_puzzle01("day04_input.txt")
