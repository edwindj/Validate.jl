using Rule

mutable struct RuleSet
  rules::Vector{Rule}
end

# multiple constructors?
# maybe introduce a macro @ruleset?

function to_yaml(io::IO, rulesset::RuleSet)
  for rule in rulesset.rules
    to_yaml(io, rule)
  end
end
