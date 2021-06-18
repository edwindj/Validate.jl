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

 d_compare = Dict(
   :>    => :<=,
   :>=   => :<,
   :<    => :>=,
   :<=   => :>,
   :(==) => :!=,
   :!=   => :(==)
 )

 d_logic = Dict(
   :|    => :&,
   :(||) => :(&&), # these are in the e.head!
   :&    => :|,
   :(&&) => :(||) # these are in the e.head!
 )

 op = e.args[1]

 if op == :(!)
    return e.args[2]
 elseif haskey(d_compare, op)
    e.args[1] = d_compare[op]
 elseif haskey(d_logic,op)
    e.args[1] = d_logic[op]
    e.args[2] = negate(e.args[2]) 
    e.args[3] = negate(e.args[3]) 
 else 
    e = :(!$e)
 end

 if e.args[1] == :!= && e.args[3] isa Bool
    e.args[1] = :(==)
    e.args[3] = !e.args[3]
 end
 e
end

function negate(s::Symbol)
  Expr(:call, :!, s)
end

# e = :(x > 1)
# e |> invert |> print
# :(a == 1) |> negate |> print
# :(a != 1) |> negate |> print
# :(a == true) |> negate |> print
# :(x > y) |> negate |> print
# :(a == false) |> negate |> print