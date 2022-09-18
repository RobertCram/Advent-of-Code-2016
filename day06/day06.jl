module Day6

# https://adventofcode.com/2016/day/6

include("./../aoc.jl")

using .AOC
using StatsBase

function AOC.processinput(data)
    data = split(data, '\n')
    data = map(s -> collect(s), data)
    data = reduce((result, row) -> (vcat(result, permutedims(row))), data[begin+1:end], init = permutedims(data[begin]))    
    [[data[:,i]...] for i in 1:size(data)[2]]
end

function mostoccurring(countmap)
    sort(collect(countmap), by = e -> e[2])[end][1]
end

function leastoccurring(countmap)
    sort(collect(countmap), by = e -> e[2])[begin][1]
end

function solvepart1(input)
    join(map(col -> mostoccurring(countmap(col)), input))
end

function solvepart2(input)
    join(map(col -> leastoccurring(countmap(col)), input))
end

puzzles = [
    Puzzle(6, "test 1", "input-test1.txt", solvepart1, "easter"),
    Puzzle(6, "deel 1", solvepart1, "gebzfnbt"),
    Puzzle(6, "test 2", "input-test1.txt", solvepart2, "advent"),
    Puzzle(6, "deel 2", solvepart2, "fykjtwyn")
]

printresults(puzzles)

end