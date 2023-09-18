using Symbolics
using Latexify
using Printf

function onevar(n, r1)
    @variables x
    a = rand(r1, n+1)
    t = a[1]
    for i = 2:n+1
        t = a[i] + t*x
    end
    simplify(expand(t))
end

function polybinop(n, op)
    t1 = onevar(n, -9:9)
    t2 = onevar(n, -9:9)
    t = op(t1,t2) |> expand |> simplify
    @printf("\\question \$(%s) %s (%s) =\$ \\fillin[\$%s\$]\n",
            latexify(t1, env=:raw), opstr(op), latexify(t2, env=:raw),
            latexify(t, env=:raw))
end


