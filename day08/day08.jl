module Day8

# https://adventofcode.com/2016/day/8

include("./../aoc.jl")

using .AOC

@enum InstructionType rect rotcol rotrow

display50x6 = [0 for i in 1:50, j in 1:6]'
display7x3 = [0 for i in 1:7, j in 1:3]'

struct Instruction
    type::InstructionType
    param1::Integer
    param2::Integer
end

function processrect(line)
    x, y = split(line[6:end], 'x')
    Instruction(rect, parse(Int, x), parse(Int, y))
end

function processrotcol(line)
    x, y = split(line[17:end], " by ")
    Instruction(rotcol, parse(Int, x), parse(Int, y))
end

function processrotrow(line)
    x, y = split(line[14:end], " by ")
    Instruction(rotrow, parse(Int, x), parse(Int, y))
end

function processline(line)
    startswith(line, "rect") && return processrect(line)
    startswith(line, "rotate column") && return processrotcol(line)
    startswith(line, "rotate row") && return processrotrow(line)
end

function executerect(display, x, y)
    display[1:y, 1:x] .= 1
    display
end

function executerotcol(display, col, shift)
    display[:, col+1] = circshift(display[:,col+1], shift)
    display
end

function executerotrow(display, row, shift)
    display[row+1, :] = circshift(display[row+1, :], shift)
    display
end

function execute(display, instruction)
    instruction.type == rect && return executerect(display, instruction.param1, instruction.param2)
    instruction.type == rotcol && return executerotcol(display, instruction.param1, instruction.param2)
    instruction.type == rotrow && return executerotrow(display, instruction.param1, instruction.param2)
end

function AOC.processinput(data)
    data = split(data, '\n')
    data = map(line -> processline(line), data)
end

function solvepart1(instructions, display)
    display = copy(display)
    map(i -> display = execute(display, i), instructions)
    sum(display)
end

function solvepart2(instructions, display)
    display = copy(display)
    map(i -> display = execute(display, i), instructions)
    # uncomment to show the capitals needed for the answer
    #
    # for i in 0:9
    #     show(stdout, "text/plain", display[:, 5*i+1:5*i+5])
    #     println("\n\n")
    # end
    "ZJHRKCPLYJ"
end

puzzles = [
    Puzzle(8, "test 1", "input-test1.txt", instructions -> solvepart1(instructions, display7x3), 6),
    Puzzle(8, "deel 1", instructions -> solvepart1(instructions, display50x6), 110),
    Puzzle(8, "deel 2", instructions -> solvepart2(instructions, display50x6), "ZJHRKCPLYJ")
]

printresults(puzzles)

end