module Day10

# https://adventofcode.com/2016/day/10

include("./../aoc.jl")

using .AOC

abstract type Instruction end

struct Input <: Instruction
    targetbot::Integer
    value::Integer
end

struct Rule <: Instruction    
    sourcebot::Integer
    lowbot::Integer
    highbot::Integer
end

struct Bot
    id::Integer
    values::Set{Integer}
end

function processinput(line)
    s = split(line)
    Input(parse(Int, s[6]), parse(Int, s[2]))
end

function processtransfer(line)
    s = split(line)
    # outputs are represented by id = 1000 + output id
    lowtarget = parse(Int, s[7]) + (s[6] == "output" ? 1000 : 0)
    hightarget = parse(Int, s[12]) + (s[11] == "output" ? 1000 : 0)
    Rule(parse(Int, s[2]), lowtarget, hightarget)
end

function processline(line)
    startswith(line, "value") && return processinput(line)
    return processtransfer(line)
end

global Bots
global Answer

function AOC.processinput(data)
    global Bots = []
    data = map(line -> processline(line), split(data, '\n'))
end

function getbot(id)
    bots = filter(bot -> bot.id == id, Bots)   
    isempty(bots) && (push!(Bots, Bot(id, Set())); return Bots[end])
    return bots[1]
end

function execute(input::Input)
    bot = getbot(input.targetbot)
    push!(bot.values, input.value)
end

function initialize(inputs)
    map(input -> execute(input), inputs)
end

function transfer(bot::Bot, rules, targetpair)
    rule = rules[findfirst(rule -> rule.sourcebot == bot.id, rules)]
    push!(getbot(rule.lowbot).values, minimum(bot.values))
    push!(getbot(rule.highbot).values, maximum(bot.values))
    Set(targetpair) == bot.values && (global Answer = bot.id)
    empty!(bot.values)
end


function solvepart1(input, targetpair)
    initialize(filter(i -> typeof(i) == Input, input))
    rules = filter(i -> typeof(i) == Rule, input)
    while true
        bots2transfer = filter(bot -> bot.id < 1000 && length(bot.values) == 2, Bots)
        isempty(bots2transfer) && break
        foreach(bot -> transfer(bot, rules, targetpair), bots2transfer)
    end
    Answer, reduce((result, bot) -> result *= minimum(bot.values), filter(bot -> bot.id >= 1000 && bot.id <= 1002, Bots), init = 1)
end


puzzles = [
    Puzzle(10, "test 1", "input-test1.txt", input -> solvepart1(input, (5, 2))[1], 2),
    Puzzle(10, "deel 1", input -> solvepart1(input, (61, 17))[1], 86),
    Puzzle(10, "test 1", "input-test1.txt", input -> solvepart1(input, (5, 2))[2], 30),
    Puzzle(10, "deel 2", input -> solvepart1(input, (61, 17))[2], 22847)
]

printresults(puzzles)

end