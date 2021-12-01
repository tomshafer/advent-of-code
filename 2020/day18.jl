
function readinput(file::String)
    readlines(file)
end

function rules_lr(expr::Array)
    value = parse(Int, expr[1])
    for i in 2:2:length(expr)
        op = expr[i]
        b = parse(Int, expr[i + 1])
        if op == "*"
            value *= b
        elseif op == "+"
            value += b
        end
    end
    value
end

function parse_expr01(input)
    expr = copy(input)
    # Collapse parens expressions
    while sum(expr .== "(") > 0
        istart = maximum(i for (i, e) in enumerate(expr) if e == "(")
        iend = minimum(i for (i, e) in enumerate(expr) if e == ")" && i > istart)
        value = parse_expr01(expr[istart + 1:iend - 1])
        deleteat!(expr, istart:iend)
        insert!(expr, istart, "$value")
    end
    rules_lr(expr)
end

function day18_puzzle01(file::String)
    sum(parse_expr01([c for c in split(line, "") if c ≠ " "]) for line in readinput(file))
end

function parse_expr02(input)
    expr = copy(input)
    # Collapse parens expressions
    while sum(expr .== "(") > 0
        istart = maximum(i for (i, e) in enumerate(expr) if e == "(")
        iend = minimum(i for (i, e) in enumerate(expr) if e == ")" && i > istart)
        value = parse_expr01(expr[istart + 1:iend - 1])
        deleteat!(expr, istart:iend)
        insert!(expr, istart, "$value")
    end
    rules_pm(expr)
end

function rules_pm(expr::Array)
    value = 0
    plusses = findall(expr .== "+")
    for i in reverse(plusses)
        a, b = parse.(Int, (expr[i - 1], expr[i + 1]))
        deleteat!(expr, i - 1:i + 1)
        insert!(expr, i - 1, "$(a + b)")
    end

    value = parse(Int, expr[1])
    for i in 2:2:length(expr)
        op = expr[i]
        b = parse(Int, expr[i + 1])
        if op == "*"
            value *= b
        elseif op == "+"
            value += b
        end
    end
    value
end

function parse_expr02(input)
    expr = copy(input)
    while sum(expr .== "(") > 0
        istart = maximum(i for (i, e) in enumerate(expr) if e == "(")
        iend = minimum(i for (i, e) in enumerate(expr) if e == ")" && i > istart)
        value = parse_expr02(expr[istart + 1:iend - 1])
        deleteat!(expr, istart:iend)
        insert!(expr, istart, "$value")
    end
    rules_pm(expr)
end

function day18_puzzle02(file::String)
    sum(parse_expr02([c for c in split(line, "") if c ≠ " "]) for line in readinput(file))
end

day18_puzzle01("day18_input.txt")
day18_puzzle02("day18_input.txt")
