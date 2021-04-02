function rewrite_equality(e::Expr, eps = 1e-8)
  if e.head != :call || !(e.args[1] in [:>=, :<=, :(==)])
    return e
  end

  op, left, right = e.args

  if op == :>=
    e = :($left >= $right - $eps)
  elseif op == :<=
    e = :($left <= $right + $eps)
  elseif op == :(==)
    #e = :(abs(left - $right) <= $eps)
    e = :($right - $eps <= $left <= $right + $eps)
  end
  e
end


e = :(x >= 1)
rewrite_equality(e)
rewrite_equality(:(x == 1))
rewrite_equality(:(x <= 1))