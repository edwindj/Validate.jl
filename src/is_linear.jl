# Sub expressions

"Test if expression is part of a linear expression"
is_linear_part(s::Any) = false
is_linear_part(s::Symbol) = true
is_linear_part(s::Real) = true

function is_linear_part(e::Expr)
  if !(e.head == :call)
    return false
  end
  
  op = e.args[1]
  if op in [:*, :\]
    is_lin = e.args[2] isa Real
  elseif op == :/
    is_lin = e.args[3] isa Real
  else
    is_lin = op in [:+, :-]
  end

  if !is_lin
    return false
  end

  for part in e.args[2:end]
    if !is_linear_part(part)
      return false
    end
  end

  true
end

"Test if expression is linear expression"
is_linear(e) = false

function is_linear(e::Expr)
  if !(e.head == :call)
    return false
  end
  
  op = e.args[1]

  if !(op in [:>, :<, :>=, :<=, :(==)])
    return false
  end

  for part in e.args[2:end]
    if !is_linear_part(part)
      return false
    end
  end

  true
end

# is_linear_part(:x)
# is_linear_part("test")
# is_linear_part(:(y <= 1))
# is_linear_part(1)

# is_linear(:x)
# is_linear("test")
# is_linear(:(y <= 1))
# is_linear(1)

# e = :(x + y > 1)
# is_linear(e)

# is_linear_part(:(3x))
# is_linear(:(3x+y >= 1))
# is_linear_part(:(x + 3(y+1)))
# is_linear(:(x == 1))
