mutable struct Rule
  expr::Expr
  name::String
  description::String
end


struct Rules
  rules::Array{Rule}
end

iterate(rules::Rules) = iterate(rules.rules)
iterate(rules::Rules, state) = iterate(rules.rules, state)

push!(rules::Rules, rule::Rule) = push!(rules.rules, rule)


"""
Create a Rule
"""
Rule(expr::Expr) = Rule(expr, "", "")

Rule(s::String) = Rule(Meta.parse(s))

"Create a rule"
macro rule(x::Expr, name = "", description = "")
  Rule(x, name, description)
end

macro rule(name::String, x::Expr, description = "")
  Rule(x, name, description)
end

map(x -> x^2, [1,2])

collect(x->x^2 for x in [1,2])

Rule("x>1")

@rule( x < 1
     , "Fiets"
     ,"""
Beschrijving van deze regel
""")

@rule "fietsje"  x > 1 """

Deze regel beschrijft de verschillende mogelijkheden
"""

@rule x < 1 "Fiets" """
Beschrijving van deze regel
"""

[@rule(x < 1),@rule(y > 1)]