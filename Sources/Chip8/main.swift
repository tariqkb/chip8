import Chip8Lib

var program = try Program(ch8FilePath: "games/Pong 2 (Pong hack) [David Winter, 1997].ch8")
program.withPause()

print("starting game engine")
let gameEngine = GameEngine(program: program)
