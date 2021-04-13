import Validate.replace_variables
using Test

@testset "Replace variables" begin
    @test replace_variables(:x, Set([:x])) == 
                            :(_.x)
  
    @test replace_variables(:x, Set([:y])) ==
                            :x
  
    @test replace_variables(:(  x + 3y > 1 +   z), Set([:x,:z])) ==
                            :(_.x + 3y > 1 + _.z)
end

# extract_variables([e
#         ,:(if a > 1; b > 2; end)
#         ,:(w<v<1)
#         ])