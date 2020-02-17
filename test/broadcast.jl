using Base.Broadcast: broadcasted
bstyle = Base.Broadcast.DefaultArrayStyle{1}()

@testset "broadcast" begin
    for (mr,br,sr) in ((OneToMRange(10),         OneTo(10),              OneToSRange(10)),
                       (UnitMRange(1, 10),       UnitRange(1, 10),       UnitSRange(1, 10)),
                       (StepMRange(1, 1, 10),    StepRange(1, 1, 10),    StepSRange(1, 1, 10)),
                       (LinMRange(1, 10, 10),    LinRange(1, 10, 10),    LinSRange(1, 10, 10)),
                       (StepMRangeLen(1., 1., 10), StepRangeLen(1., 1., 10), StepSRangeLen(1., 1., 10))
                      )
        @testset "" begin
            @test broadcasted(bstyle, +, mr) ==
                  broadcast(+, br) ==
                  broadcasted(bstyle, +, sr)

            @test broadcasted(bstyle, -, mr) ==
                  broadcast(-, br) ==
                  broadcasted(bstyle, -, sr)

            @test broadcasted(bstyle, +, 1, mr) ==
                  broadcast(+, 1, br) ==
                  broadcasted(bstyle, +, 1, sr)

            @test broadcasted(bstyle, -, 1, mr) ==
                  broadcast(-, 1, br) ==
                  broadcasted(bstyle, -, 1, sr)

            @test broadcasted(bstyle, +, mr, 1) ==
                  broadcast(+, br, 1) ==
                  broadcasted(bstyle, +, sr, 1)

            @test broadcasted(bstyle, -, mr, 1) ==
                  broadcast(-, br, 1) ==
                  broadcasted(bstyle, -, sr, 1)

            @test broadcasted(bstyle, *, 1, mr) ==
                  broadcast(*, 1, br) ==
                  broadcasted(bstyle, *, 1, sr)

            @test broadcasted(bstyle, *, mr, 1) ==
                  broadcast(*, br, 1) ==
                  broadcasted(bstyle, *, sr, 1)

            @test broadcasted(bstyle, \, 1, mr) ==
                  broadcast(\, 1, br) ==
                  broadcasted(bstyle, \, 1, sr)

            @test broadcast(bstyle, /, mr, 2) ==
                  broadcast(bstyle, /, sr, 2) ==
                  broadcast(bstyle, /, br, 2)

            @test -(mr, (2 .* br)) == -(br, (2 .* br)) == -(sr, (2 .* br))
            @test -((2 .* br), mr) == -((2 .* br), br) == -((2 .* br), sr)

            @test +(mr, (1 .+ br)) == +(br, (1 .+ br)) == +(sr, (1 .+ br))
            @test +((1 .+ br), mr) == +((1 .+ br), br) == +((1 .+ br), sr)

            @test *(mr, 2) == *(sr, 2) == *(br, 2)
            @test *(2, mr) == *(2, sr) == *(2, br)
        end
    end
end
