using Printf

include("arith.jl")

function mkcomp(nmax)
    ps = primes(nmax)
    push!(ps, 1)
    nc = rand(2:10)
    n = 1
    for i = 1:nc
        t = n
        n *= rand(ps)
        if n > 20000
            n = t
            break
        end
    end
    n
end

function dayprimes(nday, nmax)
    println("\\section*{Day $nday}")
    println("\\begin{questions}")
    for k = 1:25
        n = mkcomp(nmax)

        fs = Vector()
        for (b,e) in factor(n)
            if e == 1
                push!(fs, "$b")
            else
                push!(fs, "$b^{$e}")
            end
        end
        ans = join(fs, " \\cdot ")
        println("\\question \$ $n =  \$ \\fillin[\$ $ans \$]")
    end
    println("\\end{questions}")
end

function main()
    parsed_args = parse_commandline()
    seed = parsed_args["seed"]
    Random.seed!(seed)
    
    write_latex("Prime factorization") do
        println("""(Primes up to 19 are used.)
\\section*{Examples}
\\begin{enumerate}
    \\item \$ 10 = 2 \\cdot 5\$.
    \\item \$ 13 = 13\$ (prime numbers as they are).
    \\item \$ 4860 = 2^{2}\\cdot 3^{5} \\cdot 5\$.
\\end{enumerate}
""")
        println("\\twocolumn")
        for nday = 1:6
            if nday <= 2
                dayprimes(nday, 7)
            elseif nday <= 4
                dayprimes(nday, 11)
            else
                dayprimes(nday, 19)
            end
        end

    end
end

main()


