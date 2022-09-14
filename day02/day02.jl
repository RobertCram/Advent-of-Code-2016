module Day02

# https://adventofcode.com/2016/day/2

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    split(data, '\n')
end

MOVES1 = Dict(
    ('1', 'D') => '4',
    ('1', 'R') => '2',

    ('2', 'D') => '5',
    ('2', 'L') => '1',
    ('2', 'R') => '3',

    ('3', 'D') => '6',
    ('3', 'L') => '2',

    ('4', 'U') => '1',
    ('4', 'D') => '7',
    ('4', 'R') => '5',

    ('5', 'U') => '2',
    ('5', 'D') => '8',
    ('5', 'L') => '4',
    ('5', 'R') => '6',

    ('6', 'U') => '3',
    ('6', 'D') => '9',
    ('6', 'L') => '5',

    ('7', 'U') => '4',
    ('7', 'R') => '8',

    ('8', 'U') => '5',
    ('8', 'L') => '7',
    ('8', 'R') => '9',

    ('9', 'U') => '6',
    ('9', 'L') => '8',
)

MOVES2 = Dict(
    ('1', 'D') => '3',

    ('2', 'D') => '6',
    ('2', 'R') => '3',

    ('3', 'U') => '1',
    ('3', 'D') => '7',
    ('3', 'L') => '2',
    ('3', 'R') => '4',

    ('4', 'D') => '8',
    ('4', 'L') => '3',

    ('5', 'R') => '6',

    ('6', 'U') => '2',
    ('6', 'D') => 'A',
    ('6', 'L') => '5',
    ('6', 'R') => '7',

    ('7', 'U') => '3',
    ('7', 'D') => 'B',
    ('7', 'L') => '6',
    ('7', 'R') => '8',

    ('8', 'U') => '4',
    ('8', 'D') => 'C',
    ('8', 'L') => '7',
    ('8', 'R') => '9',

    ('9', 'L') => '8',

    ('A', 'U') => '6',
    ('A', 'R') => 'B',

    ('B', 'U') => '7',
    ('B', 'D') => 'D',
    ('B', 'L') => 'A',
    ('B', 'R') => 'C',

    ('C', 'U') => '8',
    ('C', 'L') => 'B',

    ('D', 'U') => 'B',
)

function execute(sequence, button, moves)
    reduce((button, move) -> get(moves, (button, move), button), collect(sequence), init = button)
end

function solve(sequences, moves)
    button = '5'
    buttons = map(sequence -> button = execute(sequence, button, moves), sequences)
    join(buttons)
end

function solvepart1(sequences)
    solve(sequences, MOVES1)
end

function solvepart2(sequences)
    solve(sequences, MOVES2)
end

puzzles = [
    Puzzle(02, "test 1", "input-test1.txt", solvepart1, "1985"),
    Puzzle(02, "deel 1", solvepart1, "18843"),
    Puzzle(02, "test 2", "input-test1.txt", solvepart2, "5DB3"),
    Puzzle(02, "deel 2", solvepart2, "67BB9")
]

printresults(puzzles)

end