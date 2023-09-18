using Printf
using Primes
using Random
using ArgParse
using Symbolics
using Latexify
using Nemo

function fracstr(b)
    a = abs(b)
    s = sign(b) < 0 ? "-" : ""
    n = numerator(a)
    d = denominator(a)
    d == 1 ? string(Int(b)) : "$s\\frac{$n}{$d}"
end

function opstr(op)
    if op == (+)
        "+"
    elseif op == (-)
        "-"
    elseif op == (*)
        "\\times"
    elseif op == (//)
        "\\div"
    elseif op == (/)
        "\\div"
    else
        "?"
    end
end

function mkbin(a, b, op)
    sa = fracstr(a)
    sb = b < 0 ? "(" * fracstr(b) * ")" : fracstr(b)
    sc = fracstr(op(a,b))
    so = opstr(op)
    println("\\question \$ $sa $so $sb =  \$ \\fillin[\$ $sc \$]")
end

function mkintdiv(a,b)
    sa = fracstr(a)
    sb = b < 0 ? "(" * fracstr(b) * ")" : fracstr(b)
    q,r = (a ÷ b),(a%b)
    sq = q == 0 ? "" : fracstr(q)
    sr = r == 0 ? "" : (q > 0 ? "+" : "") * fracstr(r//b)
    println("\\question \$ $sa \\div $sb =  \$ \\fillin[\$ $sq $sr \$]")
end

function mkfracfrac(a, b)
    sa = fracstr(a)
    sb = fracstr(b)
    sc = fracstr(a/b)
    println("\\question {\\Large\$ \\frac{~$sa~}{$sb} =  \$} \\fillin[\$ $sc \$]")
end


function genintpair(nm1, nm2)
    while true
        a = rand(nm1)
        b = rand(nm2)
        if a != b && a*b != 0
           return (a,b)
        end
    end
end

function genfrac(nm, dm)
    while true 
        n = rand(nm)
        d = rand(dm)
        q = n//d
        if q != 1
            return q
        end
    end
end

function arithint(r1, r2, op)
    for i = 1:25
        a, b = genintpair(r1, r2)
        if op == ÷
            mkintdiv(a,b)
        else
            mkbin(a, b, op)
        end
    end
end

function arithfrac(rn, rd, op)
    for i = 1:25
        a = genfrac(rn, rd) 
        b = genfrac(rn, rd) 
        mkbin(a, b, op)
    end
end

function write_latex(writer, title)
    println("%%\\documentclass[a4paper,12pt]{exam}")
    println("\\documentclass[a4paper,12pt,answers]{exam}")
    println("\\pagestyle{myheadings}")
    println("\\markright{Name/Student No.:}")
    println("\\begin{document}")
    @printf("\\title{%s}", title)
    println("\\maketitle")
    println("\\thispagestyle{myheadings}")

    writer()
    println("\\end{document}")
end

function parse_commandline()
    s = ArgParseSettings()
    @add_arg_table s begin
        "--seed"
        help = "random seed (13579)"
        arg_type = Int64
        default = 13579
    end

    return parse_args(s)
end
