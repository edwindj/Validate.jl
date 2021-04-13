import Validate.Dnf
import Validate.to_dnf
using Test

@testset "Dnf" begin
    to_dnf(:(x>1))
    # dnf = Dnf([:(x>1) , :(y<1), :(a==true)])
    # print(dnf)
    # to_expr(dnf)
end