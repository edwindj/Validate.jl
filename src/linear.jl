function is_linear_sub(e::Symbol)
  true
end

function is_linear_sub(e::Number)
  true
end

function is_linear_sub(e::Expr)
  if (e.args[1] in [:+, :-])
    return is_linear_sub(e.args[2]) && is_linear_sub(e.args[3])
  end
  if (e.args[1] == :*)
    return isa(e.args[2], Number) && is_linear_sub(e.args[3])
  end
  if (e.args[1] == :/)
    return is_linear_sub(e.args[2]) && isa(e.args[3], Number) 
  end
  false
end

function is_linear(e::Expr)
  if e.head != :call
    return false 
  end
  
  if !(e.args[1] in [:>, :>=, :<, :<=, :(==)])
    return false
  end
  
  return is_linear_sub(e.args[2]) && is_linear_sub(e.args[3])
  false
end


e = :(x + 3 >= 2y)
is_linear(e)
