import Chip8Lib
import SDL2

class GameEngine {
    var input: Input
    var graphics: Graphics
    var audio: Audio
    var interpreter = Interpreter()
    
    init(program: Program) {
        if SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO|SDL_INIT_EVENTS|SDL_INIT_TIMER) != 0 {
            fatalError("sdl - error initializing")
        }

        graphics = Graphics()
        input = Input(interpreter: interpreter)
        audio = Audio(tone: 440)

        interpreter.load(program: program)
        
        gameLoop: while true {
            
            var keyPressed: Key? = nil
            
            var event = SDL_Event()
            while SDL_PollEvent(&event) != 0 {
                let inputEvent = input.handle(event: event)
                
                if case Input.Event.quit = inputEvent {
                    break gameLoop
                }
                
                if event.type == SDL_QUIT.rawValue {
                    break gameLoop
                }
                
                if case Input.Event.keypress(let key) = inputEvent {
                    keyPressed = key
                }
            }
            
            if let interpreterEvent = interpreter.update(fixedRate: graphics.refreshRate,
                                                         keyPressed: keyPressed) {
                switch interpreterEvent {
                case .quit:
                    break gameLoop
                case .draw:
                    graphics.handle(interpreter: interpreter)
                }
            }
            
            audio.handle(interpreter: interpreter)
            
            keyPressed = nil
        }
    }
    
    deinit {
        SDL_Quit()
    }
}
