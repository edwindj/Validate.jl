replace_variables(s::Any, vars::Set{Symbol}) = s

function replace_variables(s::Symbol, vars::Set{Symbol})
  if s in vars
    return :(_.$s)
  end
  s
end

function replace_variables(e::Expr, vars::Set{Symbol})
  parts = []
  if e.head in [:block, :if]
    parts =  e.args
  elseif e.head == :call
    parts = e.args[2:end]
  elseif e.head == :comparison
    parts = e.args[1:2:end]
  end


  parts = map(part -> replace_variables(part, vars), parts)

  if e.head in [:block, :if]
    e.args = parts
  elseif e.head == :call
    e.args[2:end] = parts
  elseif e.head == :comparison
    e.args[1:2:end] = parts
  end

  e
end

function replace_variables(exprs::Array{Expr, 1}, vars::Set{Symbol} = Set{Symbol}())
  map(expr::Expr -> replace_variables(expr,vars), exprs)
end
