
include("day08_puzzle01.jl")

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

# day08_puzzle02("day08_input.txt")
