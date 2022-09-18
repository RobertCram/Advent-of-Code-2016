module Day5

# https://adventofcode.com/2016/day/5

include("./../aoc.jl")

using .AOC
using MD5

function AOC.processinput(data)
    data
end

function solvepart1(doorid)
    hash = ""
    password = ""
    salt = 0
    for i in 1:8
        while true
            hash = bytes2hex(md5(doorid * string(salt)))
            (hash[1:5] == "00000") && break
            salt += 1
        end
        password *= hash[6]
        salt += 1
    end    
    password
end

function solvepart2(doorid)
    hash = ""
    position = 0
    password = ['-' for i in 1:8]
    salt = 0
    found = 0
    while found < 8
        while true
            hash = bytes2hex(md5(doorid * string(salt)))
            position = parse(Int, hash[6], base=16)
            (hash[1:5] == "00000") && (position < 8)  && (password[position + 1] == '-') && break
            salt += 1
        end
        password[position + 1] = hash[7]
        salt += 1
        found += 1
    end    
    join(password)
end

puzzles = [
    Puzzle(5, "test 1", "input-test1.txt", solvepart1, "18f47a30"),
    Puzzle(5, "deel 1", solvepart1, "801b56a7"),
    Puzzle(5, "test 2", "input-test1.txt", solvepart2, "05ace8e3"),
    Puzzle(5, "deel 2", solvepart2, "424a0197")
]

printresults(puzzles)

end