function is_categorical(s::Any, sub = false)
  false
end

function is_categorical(s::AbstractString, sub = false)
  sub
end

function is_categorical(s::AbstractArray{String, 1}, sub = false)
  sub
end

function is_categorical(e::Expr, sub = false)
  
  if !(e.head in [:if, :call])
    return false
  end

  if (sub)
    op = e.args[1]
    if op in [:in, :(==), :∈, :∉, :!=]
      for part in e.args[2:end]
        if !is_categorical(part, true)
          return false
        end
      end
      return true
    else
      return false
    end
  end

  true
end

# e = :(v in ["a", "b"])

# is_categorical("a")
# is_categorical("a", true)
# is_categorical(["a"])
# is_categorical(["a"], true)

# is_categorical(e)
# is_categorical(e, true)