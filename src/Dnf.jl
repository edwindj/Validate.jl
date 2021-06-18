import Base.print
#import "is_linear.jl"
#import "is_categorical.jl"

"Disjunctive normal form"
struct Dnf
  exprs::Array{Expr}
end

function print(io::IO, dnf::Dnf)
  join(io, dnf.exprs, " | ")
end

function to_expr(dnf::Dnf)
  foldl((e1,e2) -> :($e1 | $e2), dnf.exprs)
end

function to_dnf(e::Expr)
  chl = Channel{Expr}() do ch
    to_dnf(e, ch)
  end
  expr = collect(chl)
  Dnf(expr)
end

function to_dnf(e::Expr, ch::Channel{Expr})
  if e.head != :call
    return
  end

  if e.args[1] == :|
    to_dnf(e.args[2], ch)
    to_dnf(e.args[3], ch)
    return
  end
  if is_linear(e)
    put!(ch, e)
  end
end

# dnf = Dnf([:(x>1) , :(y<1), :(a==true)])
# to_expr(dnf)

# e = :((x>1)| (z>1))
# to_dnf(e)