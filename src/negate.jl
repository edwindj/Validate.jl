function invert(e::Expr)
    if e.head != :call
        return e
    end

    # check if linear
    op  = e.args[1]
    if op == :(>)
        e.args[1] = :(<=)
    elseif op == :(>=)
        e.args[1] = :(<)
    elseif op == :(<)
        e.args[1] = :(>=)
    elseif op == :(<=)
        e.args[1] = :(>)
    end
    e
end

function negate(e::Expr)
 #check if is_categorical
 if e.head != :call
    return e
 end

 op = e.args[1]

 if op == :(!)
    e = e.args[2]
 elseif op == :(==)
    if e.args[3] === :(true)
      e.args[3] = :(false)
    elseif e.args[3] === :(false)
      e.args[3] = :(true)
    else 
      e.args[1] = :(!=)
    end
 elseif op == :(!=)
    e.args[1] = :(==)
 else 
    e = :(!$e)
 end
 e
end

# e = :(x > 1)
# e |> invert |> print
# :(a == 1) |> negate |> print
# :(a != 1) |> negate |> print
# :(a == true) |> negate |> print
# :(a == false) |> negate |> print