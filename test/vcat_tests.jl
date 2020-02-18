@testset "vcat_sort" begin
    @testset "Forward Forward" begin
        for (x, y, ret, cmp) in (([1, 2, 3], [4, 5, 6], [1, 2, 3, 4, 5, 6], "< < gap"),
                                 ([1, 2, 3], [2, 3, 4], [1, 2, 2, 3, 3, 4], "< <"),
                                 ([1, 2, 5], [2, 3, 4], [1, 2, 2, 3, 4, 5], "< >"),
                                 ([1, 3, 5], [2, 3, 5], [1, 2, 3, 3, 5, 5], "< =="),
                                 ([3, 4, 5], [1, 3, 6], [1, 3, 3, 4, 5, 6], "> <"),
                                 ([4, 5, 6], [1, 2, 3], [1, 2, 3, 4, 5, 6], "> > gap"),
                                 ([3, 4, 5], [1, 2, 4], [1, 2, 3, 4, 4, 5], "> >"),
                                 ([3, 4, 5], [1, 2, 5], [1, 2, 3, 4, 5, 5], "> =="),
                                 ([3, 4, 7], [3, 5, 6], [3, 3, 4, 5, 6, 7], "== <"),
                                 ([3, 6, 7], [3, 4, 5], [3, 3, 4, 5, 6, 7], "== >"),
                                 ([3, 6, 7], [3, 5, 7], [3, 3, 5, 6, 7, 7], "== =="),
                                 ([1, 2, 3, 4], [2, 3, 4, 5], [1, 2, 2, 3, 3, 4, 4, 5], "Intermixed"))

            @testset "$cmp" begin
                @test @inferred(vcat_sort(x, y)) == ret
            end
        end
    end

    @testset "Forward Reverse" begin
        for (x, y, ret, cmp) in (([1, 2, 3], [6, 5, 4], [1, 2, 3, 4, 5, 6], "< < gap"),
                                 ([1, 2, 3], [4, 3, 2], [1, 2, 2, 3, 3, 4], "< <"),
                                 ([1, 2, 5], [4, 3, 2], [1, 2, 2, 3, 4, 5], "< >"),
                                 ([1, 3, 5], [5, 3, 2], [1, 2, 3, 3, 5, 5], "< =="),
                                 ([3, 4, 5], [6, 3, 1], [1, 3, 3, 4, 5, 6], "> <"),
                                 ([4, 5, 6], [3, 2, 1], [1, 2, 3, 4, 5, 6], "> > gap"),
                                 ([3, 4, 5], [4, 2, 1], [1, 2, 3, 4, 4, 5], "> >"),
                                 ([3, 4, 5], [5, 2, 1], [1, 2, 3, 4, 5, 5], "> =="),
                                 ([3, 4, 7], [6, 5, 3], [3, 3, 4, 5, 6, 7], "== <"),
                                 ([3, 6, 7], [5, 4, 3], [3, 3, 4, 5, 6, 7], "== >"),
                                 ([3, 6, 7], [7, 5, 3], [3, 3, 5, 6, 7, 7], "== =="))
            @testset "$cmp" begin
                @test @inferred(vcat_sort(x, y)) == ret
            end
        end
    end

    @testset "Reverse Forward" begin
        for (x, y, ret, cmp) in (([3, 2, 1], [4, 5, 6], [6, 5, 4, 3, 2, 1], "< < gap"),
                                 ([3, 2, 1], [2, 3, 4], [4, 3, 3, 2, 2, 1], "< <"),
                                 ([5, 2, 1], [2, 3, 4], [5, 4, 3, 2, 2, 1], "< >"),
                                 ([5, 3, 1], [2, 3, 5], [5, 5, 3, 3, 2, 1], "< =="),
                                 ([5, 4, 3], [1, 3, 6], [6, 5, 4, 3, 3, 1], "> <"),
                                 ([6, 5, 4], [1, 2, 3], [6, 5, 4, 3, 2, 1], "> > gap"),
                                 ([5, 4, 3], [1, 2, 4], [5, 4, 4, 3, 2, 1], "> >"),
                                 ([5, 4, 3], [1, 2, 5], [5, 5, 4, 3, 2, 1], "> =="),
                                 ([7, 4, 3], [3, 5, 6], [7, 6, 5, 4, 3, 3], "== <"),
                                 ([7, 6, 3], [3, 4, 5], [7, 6, 5, 4, 3, 3], "== >"),
                                 ([7, 6, 3], [3, 5, 7], [7, 7, 6, 5, 3, 3], "== =="))
            @testset "$cmp" begin
                @test @inferred(vcat_sort(x, y)) == ret
            end
        end
    end

    @testset "Reverse Reverse" begin
        for (x, y, ret, cmp) in (([3, 2, 1], [6, 5, 4], [6, 5, 4, 3, 2, 1], "< < gap"),
                                 ([3, 2, 1], [4, 3, 2], [4, 3, 3, 2, 2, 1], "< <"),
                                 ([5, 2, 1], [4, 3, 2], [5, 4, 3, 2, 2, 1], "< >"),
                                 ([5, 3, 1], [5, 3, 2], [5, 5, 3, 3, 2, 1], "< =="),
                                 ([5, 4, 3], [6, 3, 1], [6, 5, 4, 3, 3, 1], "> <"),
                                 ([6, 5, 4], [3, 2, 1], [6, 5, 4, 3, 2, 1], "> > gap"),
                                 ([5, 4, 3], [4, 2, 1], [5, 4, 4, 3, 2, 1], "> >"),
                                 ([5, 4, 3], [5, 2, 1], [5, 5, 4, 3, 2, 1], "> =="),
                                 ([7, 4, 3], [6, 5, 3], [7, 6, 5, 4, 3, 3], "== <"),
                                 ([7, 6, 3], [5, 4, 3], [7, 6, 5, 4, 3, 3], "== >"),
                                 ([7, 6, 3], [7, 5, 3], [7, 7, 6, 5, 3, 3], "== =="))
            @testset "$cmp" begin
                @test @inferred(vcat_sort(x, y)) == ret
            end
        end
    end
end

@testset "first_segment" begin
    #@test vcat_sort([1, 3, 2, 6], [6, 3, 4, 9]) == [1, 3]
    @test vcat_sort(Int[], [6, 3, 4, 9]) == [3, 4, 6, 9]
    @test vcat_sort([1, 3, 2, 6], Int[]) == [1, 2, 3, 6]
    @test vcat_sort([1, 3, 2, 6], [7, 8, 9, 7]) == [1, 2, 3, 6, 7, 7, 8, 9]
    @test vcat_sort([7, 8, 9, 7], [1, 3, 2, 6]) == [1, 2, 3, 6, 7, 7, 8, 9]

    @test vcat_sort([1, 2, 3, 6], [7, 8, 9, 7]) == [1, 2, 3, 6, 7, 7, 8, 9]
    @test vcat_sort([7, 8, 9, 7], [1, 2, 3, 6]) == [1, 2, 3, 6, 7, 7, 8, 9]
    @test vcat_sort([1, 3, 2, 6], [7, 7, 8, 9]) == [1, 2, 3, 6, 7, 7, 8, 9]
    @test vcat_sort([7, 7, 8, 9], [1, 3, 2, 6]) == [1, 2, 3, 6, 7, 7, 8, 9]

    @test vcat_sort([6, 3, 2, 1], [7, 8, 9, 7]) == [9, 8, 7, 7, 6, 3, 2, 1]
    @test vcat_sort([7, 8, 9, 7], [6, 3, 2, 1]) == [9, 8, 7, 7, 6, 3, 2, 1]
    @test vcat_sort([1, 3, 2, 6], [9, 8, 7, 7]) == [9, 8, 7, 7, 6, 3, 2, 1]
    @test vcat_sort([9, 8, 7, 7], [1, 3, 2, 6]) == [9, 8, 7, 7, 6, 3, 2, 1]
end
