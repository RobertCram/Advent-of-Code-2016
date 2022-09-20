module Day9

# https://adventofcode.com/2016/day/9

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = split(data, '\n')
end

function decompressstep(compressed)
    lb = findfirst('(', compressed)
    rb = findfirst(')', compressed)
    lb === nothing && return compressed, true

    length, repeats = parse.(Int, split(compressed[lb+1:rb-1], 'x'))
    part2repeat = replace(compressed[rb+1:rb+length], "(" => "[", ")" => "]")
    compressed[begin:lb-1] * repeat(part2repeat, repeats) * compressed[rb+length+1:end], false
end

function decompress(compressed)
    decompressed = compressed
    while true
        decompressed, finished = decompressstep(decompressed)
        finished && break
    end
    decompressed
end

function solvepart1(lines)
    map(line-> length(decompress(line)), lines)
end

function solvepart2(lines)
    map(line-> length(decompress(line)), lines)
end

puzzles = [
    Puzzle(9, "test 1", "input-test1.txt", solvepart1, [6, 7, 9, 11, 6, 18]),
    Puzzle(9, "deel 1", solvepart1, [107035]),
    # Puzzle(9, "test 2", "input-test1.txt", solvepart2, nothing),
    # Puzzle(9, "deel 2", solvepart2, nothing)
]

printresults(puzzles)

end