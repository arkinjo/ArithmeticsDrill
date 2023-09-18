
include("arith.jl")

@variables x

Latexify.set_default(cdot = false)

function onevar(x, n, r1)
    a = rand(r1, n+1)
    t = a[1]
    for i = 2:n+1
        t = a[i] + t*x
    end
    t
end

function toSymb(t)
    (Meta.parse(replace(string(t), "X" => "x")))
end

function polydiv(X, n1, n2)
    t1 = onevar(X, n1, -9:9)
    g = onevar(X, n2, -9:9)
    t3 = onevar(X, n2-1, -9:9)
    f = t1*g + t3
    sf = latexify(toSymb(f), env=:raw)
    sg = latexify(toSymb(g), env=:raw)
    q,r = divrem(f,g)
    sq = latexify(toSymb(q), env=:raw)
    sr = latexify(toSymb(r), env=:raw)
    @printf("\\question \$ (%s) \\div (%s) =\$ \\fillin[\$ %s, ~ (%s)\$]\n",
            sf, sg, sq, sr)
end

function polybinop(X, n1, n2, op)
    t1 = onevar(X, n1, -9:9)
    t2 = onevar(X, n2, -9:9)
    s1 = latexify(toSymb(t1), env=:raw)
    s2 = latexify(toSymb(t2), env=:raw)
    t3 = op(t1,t2)
    s3 = latexify(toSymb(t3), env=:raw)
    @printf("\\question \$ (%s) %s (%s) =\$ \\fillin[\$%s\$]\n",
            s1, opstr(op), s2, s3)
end

function daypoly(nday, X, n1, n2, op)
    println("\\section*{Day $nday}")
    println("\\begin{questions}")
    for k = 1:25
        if op == /
            polydiv(X, n1, n2)
        else
            polybinop(X, n1, n2, op)
        end
    end
    println("\\end{questions}")
    println("\\newpage")
end

function main()
    parsed_args = parse_commandline()
    seed = parsed_args["seed"]
    Random.seed!(seed)
    R, X = QQ["X"]
    write_latex("Polynomials") do
        println("""
\\section*{Examples}
\\begin{enumerate}
    \\item \$ (2x + 3) + (x - 5) = 3x - 3. \$
    \\item \$ (9x+6)\\times(5x^2 + 2x -4) = 45x^3 + 48x^2 - 24x - 24. \$
    \\item \$ (20x^4 + 7x^3 + 24x^2 - 21x +1)\\div (4x^2 + 3x + 6) = 5x^2 - 2x, ~ (-9x +1).\$\\\\ quotient, (remainder), that is,
\\[20x^4 + 7x^3 + 24x^2 - 21x +1 = (4x^2 + 3x + 6)\\underline{(5x^2 - 2x)} + \\underline{(-9x +1)}\\]
\\end{enumerate}
\\newpage
""")
        for nday = 1:10
            if nday <= 2
                daypoly(nday, X, 2, 2, +)
            elseif nday <= 4
                daypoly(nday, X, 2, 2, -)
            elseif nday <= 6
                daypoly(nday, X, 2, 2, *)
            elseif nday <= 8
                daypoly(nday, X, 2, 1, /)
            else
                daypoly(nday, X, 2, 2, /)
            end
        end
    end
end

main()


