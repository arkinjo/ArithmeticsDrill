using Printf
using Random

include("arith.jl")

function dayarithint(nday, r1, r2, op1, op2)
    println("\\section*{Day $nday}")
    println("\\begin{questions}")
    arithint(r1, r2, op1)
    println("\\newline\\newline\\newline\\newline")
    arithint(r1, r2, op2)
    println("\\end{questions}")
end

function main()
    parsed_args = parse_commandline()
    seed = parsed_args["seed"]
    Random.seed!(seed)

    write_latex("Arithmetics (Integer)") do
        println("""
\\section*{Examples}
\\begin{enumerate}
    \\item \$2 + 2 = 4\$.
    \\item \$2 - 5 = -3\$.
    \\item \$12 \\div 4 = 3\$
    \\item \$12 \\div 5 = 2 + \\frac{2}{5}\$
    \\item \$18 \\div (-4) = -4-\\frac{1}{2}\$
\\end{enumerate}
""")
        println("\\twocolumn")
        for nday = 1:20
            if nday <= 5
                dayarithint(nday, 1:10, 1:10, +, -)
            elseif nday <= 10
                dayarithint(nday, 1:20, 1:20, +, -)
            elseif nday <= 15
                dayarithint(nday, -10:10, -10:10, *, ÷)
            else
                dayarithint(nday, -20:20, -20:20, *, ÷)
            end
        end
    end
end

main()
