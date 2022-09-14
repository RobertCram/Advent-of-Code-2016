module Day03

# https://adventofcode.com/2016/day/03

include("./../aoc.jl")

using .AOC

struct Measurements
    l1::Integer
    l2::Integer
    l3::Integer
end

function AOC.processinput(data)
    data = split(data, '\n')
    data = map(l -> parse.(Int, split(l)), data)
end

function isvalidtriangle(m)
    m.l1 < m.l2 + m.l3 && m.l2 < m.l1 + m.l3 && m.l3 < m.l1 + m.l2
end

function solve(measurements)
    count(m -> isvalidtriangle(m), measurements)    
end

function solvepart1(data)
    measurements = map(a -> Measurements(a[1], a[2], a[3]), data)
    solve(measurements)
end

function solvepart2(data)
    measurements = []
    for i in 1:3:length(data)
        m1 = Measurements(data[i][1], data[i+1][1], data[i+2][1])
        m2 = Measurements(data[i][2], data[i+1][2], data[i+2][2])
        m3 = Measurements(data[i][3], data[i+1][3], data[i+2][3])
        push!(measurements, m1, m2, m3)
    end
    solve(measurements)
end

puzzles = [
    Puzzle(03, "deel 1", solvepart1, 993),
    Puzzle(03, "deel 2", solvepart2, 1849)
]

printresults(puzzles)

end