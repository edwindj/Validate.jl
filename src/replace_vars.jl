function extract_variables(s::Any, vars::Set{Symbol})
  vars
end

function extract_variables(s::Symbol, vars::Set{Symbol})
  push!(vars, s)
  vars
end

function extract_variables(e::Expr, vars::Set{Symbol} = Set{Symbol}())
 #TODO comparison operator
  parts = []
  if e.head in [:block, :if]
    parts =  e.args
  elseif e.head == :call
    parts = e.args[2:end]
  elseif e.head == :comparison
    parts = e.args[1:2:end]
  end

  for part in parts
    extract_variables(part, vars)
  end

  vars
end

function extract_variables(exprs::Array{Expr, 1}, vars::Set{Symbol} = Set{Symbol}())
  for e in exprs
    extract_variables(e, vars)
  end
  vars
end


e = :(x + 3y > 1 + z)
extract_variables([e
        ,:(if a > 1; b > 2; end)
        ,:(w<v<1)
        ])