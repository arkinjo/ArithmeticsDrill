using Printf
using Random

include("arith.jl")

function dayarithfrac(nday, nmax, dmax, op1, op2)
    println("\\section*{Day $nday}")
    println("\\begin{questions}")
    arithfrac(1:nmax, 1:dmax, op1)
    println("\\newline\\newline\\newline\\newline")
    arithfrac(1:nmax, 1:dmax, op2)
    println("\\end{questions}")
end

function main()
    parsed_args = parse_commandline()
    seed = parsed_args["seed"]
    Random.seed!(seed)
    
    write_latex("Arithmetics (Fraction)") do
        println("""
\\section*{Examples}
\\begin{enumerate}
    \\item \$\\frac{5}{2} + \\frac{1}{3} = \\frac{17}{6}\$ (Don't write ``\$2 + \\frac{5}{6}\$'').
    \\item \$\\frac{5}{7} - \\frac{9}{2} = -\\frac{53}{14}\$ (Don't write ``\$-3 - \\frac{11}{14}\$'').
    \\item \$\\frac{7}{2} \\times \\frac{5}{6} = \\frac{35}{12}\$ (Don't write ``\$2 + \\frac{11}{12}\$'').
    \\item \$\\frac{3}{10} \\div \\frac{3}{2} = \\frac{1}{5}\$.
\\end{enumerate}
""")
        println("\\twocolumn")
        for nday = 1:20
            if nday <= 5
                dayarithfrac(nday, 10, 10, +, -)
            elseif nday <= 10
                dayarithfrac(nday, 20, 20, +, -)
            elseif nday <= 15
                dayarithfrac(nday, 10, 10, *, //)
            else
                dayarithfrac(nday, 20, 20, *, //)
            end
        end
    end
end

main()
