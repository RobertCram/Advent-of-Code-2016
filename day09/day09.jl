module Day9

# https://adventofcode.com/2016/day/9

include("./../aoc.jl")

using .AOC

@enum FormatVersion V1 V2

function AOC.processinput(data)
    data = split(data, '\n')
end

function decompressedlength(compressed, formatversion)
    lb = findfirst('(', compressed)
    rb = findfirst(')', compressed)
    lb === nothing && return length(compressed)

    len, repeats = parse.(Int, split(compressed[lb+1:rb-1], 'x'))
    part2repeat = compressed[rb+1:rb+len]
    formatversion == V1 && (part2repeat = replace(part2repeat, "(" => "[", ")" => "]"))
    return (lb-1) + repeats * decompressedlength(part2repeat, formatversion) + decompressedlength(compressed[rb+len+1:end], formatversion)
end

function solvepart1(lines)
    map(line-> decompressedlength(line, V1), lines)
end

function solvepart2(lines)
    map(line-> decompressedlength(line, V2), lines)
end

puzzles = [
    Puzzle(9, "test 1", "input-test1.txt", solvepart1, [6, 7, 9, 11, 6, 18]),
    Puzzle(9, "deel 1", solvepart1, [107035]),
    Puzzle(9, "test 2", "input-test2.txt", solvepart2, [9, 20, 241920, 445]),
    Puzzle(9, "deel 2", solvepart2, [11451628995])
]

printresults(puzzles)

end