
parse_instr = function (input::String)
    op, val = split(input)
    val = parse(Int, val)
    op, val
end

function run_code(instr::Array)
    acc = 0
    executed = Set{Int}()
    i = 1
    exitcode = 0
    while true
        # Code = 1 if infinite loop, Code = 2 if ended OK
        if i in executed
            exitcode = 1
            break
        end
        if i > length(instr)
            exitcode = 2
            break
        end
        push!(executed, i)
        op, val = instr[i]
        if op == "jmp"
            i += val
            continue
        end
        if op == "acc"
            acc += val
        end
        i += 1
    end
    acc, exitcode
end

function day08_puzzle01(file::String)
    code = readlines(file)
    instr = map(parse_instr, code)
    val, _ = run_code(instr)
    println("Value: $val")
end

function day08_puzzle02(file::String)
    code = readlines(file)
    instr = map(parse_instr, code)
    out = -1
    for (i, v) in enumerate(instr)
        v[1] == "acc" && continue

        # Swap instructions at location i
        instr_copy = copy(instr)
        newop = instr_copy[i][1] == "jmp" ? "nop" : "jmp"
        instr_copy[i] = (newop, instr_copy[i][2])

        out, ec = run_code(instr_copy)
        ec == 2 && break
    end
    println("Value: $out")
end

day08_puzzle01("day08_input.txt")
day08_puzzle02("day08_input.txt")
