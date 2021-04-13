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
  if is_linear(e)
    return Dnf([e])
  end

  if is_categorical(e)
    
  end
end

# dnf = Dnf([:(x>1) , :(y<1), :(a==true)])
# print(dnf)
# to_expr(dnf)
