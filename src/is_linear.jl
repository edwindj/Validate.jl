function is_linear(s::Any, sub = false)
  false
end

function is_linear(s::Symbol, sub = false)
  sub
end

function is_linear(s::Real, sub = false)
  sub
end

function is_linear(e::Expr, sub = false)
  if !(e.head == :call)
    return false
  end
  
  op = e.args[1]
  if (!sub)
    is_lin = op in [:>, :<, :>=, :<=]
  elseif op == :*
    is_lin = e.args[2] isa Real
  else
    is_lin = op in [:+, :-]
  end

  if !is_lin
    return false
  end

  for part in e.args[2:end]
    if !is_linear(part, true)
      return false
    end
  end
  true
end


is_linear(:x)
is_linear("test")
is_linear(:(y <= 1))
is_linear(1)
is_linear(1, true)


e = :(x + y > 1)
is_linear(e)

is_linear(:(3x), true)
is_linear(:(3x+y >= 1))
is_linear(:(x + 3(y+1)), true)


# useful for rewriting it to Query.jl
v = :x
v1 = :(_.$v)



test = "
a > 1

# comment
b < 1
"

Meta.parse(test)