module Day01

# https://adventofcode.com/2016/day/01

include("./../aoc.jl")

using .AOC

@enum Direction north east south west

import Base.+
import Base.-

+(dir::Direction, inc::Integer) = Direction(mod(Int(dir) + inc, Int(typemax(Direction)) + 1))
-(dir::Direction, inc::Integer) = dir + (-inc)

struct Position
    x::Integer
    y::Integer
    facing::Direction
end

Position() = Position(0, 0, north)

distance(pos::Position) = abs(pos.x) + abs(pos.y)

function AOC.processinput(data)
    steps = split(data, ", ")
    map(step -> (direction = step[1], length = parse(Int, step[2:end])), steps)
end

function turn(pos, direction)
    direction = direction == 'R' ? 1 : -1
    Position(pos.x, pos.y, pos.facing + direction)
end

function move(pos)
    pos.facing == north && return Position(pos.x, pos.y + 1, pos.facing)
    pos.facing == east && return Position(pos.x + 1, pos.y, pos.facing)
    pos.facing == south && return Position(pos.x , pos.y - 1, pos.facing)
    pos.facing == west && return Position(pos.x - 1, pos.y, pos.facing)
end

function move(pos, length, positionlog)
    newpositions = map(_ -> pos = move(pos), 1:length)
    for pos in newpositions
        !isempty(findall(p -> pos.x == p.x && pos.y == p.y, positionlog)) && return pos, true
        !isempty(positionlog) && push!(positionlog, pos)
    end
    return pos, false
end

function newposition(pos, step, positionlog = [])
    pos = turn(pos, step.direction)
    move(pos, step.length, positionlog)
end

function solve(steps, positionlog = [])
    position = Position()
    for step in steps
        position, finished = newposition(position, step, positionlog)
        finished && break
    end
    distance(position)
end

function solvepart1(steps)
    solve(steps)
end

function solvepart2(steps)
    solve(steps, [Position()])
end

puzzles = [
    Puzzle(01, "test 1", "input-test1a.txt", solvepart1, 12),
    Puzzle(01, "test 2", "input-test1b.txt", solvepart1, 2),
    Puzzle(01, "deel 1", solvepart1, 181),
    Puzzle(01, "test 2", "input-test2.txt", solvepart2, 4),
    Puzzle(01, "deel 2", solvepart2, 140)
]

printresults(puzzles)

end