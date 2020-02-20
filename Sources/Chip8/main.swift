import Chip8Lib

var program = try Program(ch8FilePath: "games/Tank.ch8")
program.withPause()

print("starting game engine")
let gameEngine = GameEngine(program: program)
