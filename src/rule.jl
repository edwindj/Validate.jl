mutable struct Rule
  expr::Expr
  label::String
  description::String
end

#function to_dict()
# function to_yaml(rule::Rule)
#   """
#   name: $(rule.name)
#   expr: $(rule.expr)
#   description: $(rule.description)
#   """
# end

function to_yaml(rule)
  to_yaml(stdout, rule)
end

function to_yaml(io::IO, rule::Rule)
  println(io, "-  expr: ", rule.expr)
  println(io, "   label: ", rule.label)
  println(io, "   description: ", rule.description)  
end

r = Rule(:(x>y), "r1", "")

to_yaml(r)