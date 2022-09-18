module Day7

# https://adventofcode.com/2016/day/7

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = split(data, '\n')
end

function hasabba(str)
    found = false
    for i in 0:length(str)-4
        str[i+1] == str[i+4] && str[i+2] == str[i+3] && str[i+1] != str[i+2] && (found = true; break)
    end
    found
end

function getabas(supernet)
    str = supernet
    abas = []
    for i in 0:length(str)-3
        (str[i+1] == str[i+3] && str[i+1] != str[i+2]) && push!(abas, supernet[i+1:i+3])
    end
    abas
end

function hasbab(hypernet, aba)
    occursin(aba[2] * aba[1] * aba[2], hypernet)
end

function hypernetsequences(ip)
    lefts = findall('[', ip)
    rights = findall(']', ip)
    leftrights = zip(lefts, rights)
    map(lr -> ip[lr[1]+1:lr[2]-1], leftrights)
end

function supernetsequences(ip)
    ip = ']' * ip * '['
    lefts = findall('[', ip)
    rights = findall(']', ip)
    rightlefts = zip(rights, lefts)
    map(lr -> ip[lr[1]+1:lr[2]-1], rightlefts)
end

function supportstls(ip)
    count(seq -> hasabba(seq), hypernetsequences(ip)) > 0 && return false
    count(seq -> hasabba(seq), supernetsequences(ip)) > 0
end

function supportssls(ip)
    abas = collect(Iterators.flatten(map(supernet -> getabas(supernet), supernetsequences(ip))))
    sum(map(hypernet -> count(aba -> hasbab(hypernet, aba) > 0, abas), hypernetsequences(ip))) > 0
end


function solvepart1(ipaddresses)
    count(ip -> supportstls(ip), ipaddresses)
end

function solvepart2(ipaddresses)
    count(ip -> supportssls(ip), ipaddresses)
end

puzzles = [
    Puzzle(7, "test 1", "input-test1.txt", solvepart1, 2),
    Puzzle(7, "deel 1", solvepart1, 115),
    Puzzle(7, "test 2", "input-test2.txt", solvepart2, 3),
    Puzzle(7, "deel 2", solvepart2, 231)
]

printresults(puzzles)

end