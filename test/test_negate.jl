import Validate.negate
using Test

@testset "Negate" begin

  @test negate(:(!x)) == :x

  @test negate(:(x == true)) == :(x == false)

  @test negate(:(x == false)) == :(x == true)

  @test negate(:(x == y)) == :(x != y)
  
  @test negate(:(x > y)) == :(!(x > y))

end


# e = :(x > 1)
# e |> invert |> print
# :(a == 1) |> negate |> print
# :(a != 1) |> negate |> print
# :(a == true) |> negate |> print
# :(a == false) |> negate |> print