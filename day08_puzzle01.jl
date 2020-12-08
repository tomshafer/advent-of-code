
parse_instr = function(input::String)
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

# day08_puzzle01("day08_input.txt")
