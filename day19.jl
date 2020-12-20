
function readinput(file::AbstractString)
    input = readlines(file)
    rules = Dict{AbstractString,AbstractString}()

    while length(input) > 0
        rule = popfirst!(input)
        rule == "" && break

        key, value = split(rule, ':')
        value = strip(replace(value, r"[^ab0-9| ]" => ""))
        rules[key] = value
    end
    rules, input
end

function process_rule(rule::AbstractString, rules::Dict)::AbstractString
    retval = ""
    for char in split(rule)
        char = "$char"
        if occursin(char, " |abxy")
            retval = "$retval $char"
            continue
        end
        p = process_rule(rules[char], rules)
        if occursin("|", p)
            p = "($p)"
        end
        retval = "$retval $p"
    end
    strip("$retval")
end

function day19_puzzle01(file::String)
    rules, lines = readinput(file)
    rule = process_rule(rules["0"], rules)
    rule = "^$rule\$"
    result = sum(!isnothing(match(Regex(rule, "x"), line)) for line in lines)
    println("Day 19, Puzzle 1: $result")
end

function day19_puzzle02(file::String)
    rules, lines = readinput(file)
    rules["8"] = "42 | 42 8"
    rules["11"] = "42 31 | 42 11 31"
    # x = a | a x
    #   = a | a (a | a x)
    #   = a | a a | a a x ... = a{1,2,...}
    r42 = process_rule(rules["42"], rules)

    # a b | a x b = a b | a (a b | a x b) b
    #             = a b | a a b b | a a x b b
    #             = a b | a a b b | a a (a b | a x b) b b
    #             = a b | a a b b | a a a b b b | a a a x b b b
    r31 = process_rule(rules["31"], rules)

    # Trial and error shows {1,2,3,5} converges to 274
    rule = "^(($r42)+ ((($r42){1} ($r31){1})"
    for i in [2,3,5]
        rule = "$rule | (($r42){$i} ($r31){$i})"
    end
    rule = "$rule))\$"
    result = sum(!isnothing(match(Regex(rule, "x"), line)) for line in lines)
    println("Day 19, Puzzle 2: $result")
end


day19_puzzle01("day19_input.txt")
day19_puzzle02("day19_input.txt")
