module Day04

# https://adventofcode.com/2016/day/04

include("./../aoc.jl")

using .AOC
using  StatsBase

struct Room
    name::String
    id::Integer
    checksum::String
end

function line2room(line)
    Room(join(line[1:end-2]), parse(Int, line[end-1]), line[end])
end

function calculatechecksum(roomname)
    cm = countmap(roomname)
    join(map(pair -> pair[1], sort(collect(cm), by = e -> string(100-e[2], pad = 3) * string(e[1]))[1:5]))
end

function decrypt(roomname, roomid)
    join(map(c -> Char(mod(Int(c) - 97 + roomid, 26) + 97) , collect(roomname)))
end

function validrooms(rooms)
    filter(room -> calculatechecksum(room.name) == room.checksum, rooms)
end

function AOC.processinput(data)
    lines = split(data, '\n')
    lines = map(line -> replace(line[1:end-1], "[" => "-"), lines)
    lines = map(line -> split(line, '-'), lines)
    lines = map(line -> line2room(line), lines)
end

function solvepart1(rooms)
    reduce((total, room) -> total + room.id, validrooms(rooms), init = 0)
end

function solvepart2(rooms)
    filter(e -> occursin("northpole", e.name), map(room -> (room=room, name=decrypt(room.name, room.id)), validrooms(rooms)))[1].room.id
end

puzzles = [
    Puzzle(04, "test 1", "input-test1.txt", solvepart1, 1514),
    Puzzle(04, "deel 1", solvepart1, 137896),
    Puzzle(04, "test 2", _ -> decrypt("qzmtzixmtkozyivhz", 343), "veryencryptedname"),
    Puzzle(04, "deel 2", solvepart2, 501)
]

printresults(puzzles)

end