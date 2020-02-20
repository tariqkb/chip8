import SDL2
import Chip8Lib

class Input {

    enum Event {
        case keypress(key: Key)
        case quit
        case none
    }
    
    var interpreter: Interpreter
    
    init(interpreter: Interpreter) {
        self.interpreter = interpreter;
    }
    
    /// Return .keypress if any
    func handle(event sdlEvent: SDL_Event) -> Input.Event {
        var event: Input.Event = .none
        
        switch Int(sdlEvent.key.keysym.sym) {
        case SDLK_ESCAPE:
            event = .quit
        case SDLK_1:
            event = set(key: .one, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_2:
            event = set(key: .two, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_3:
            event = set(key: .three, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_4:
            event = set(key: .c, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_q:
            event = set(key: .four, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_w:
            event = set(key: .five, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_e:
            event = set(key: .six, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_r:
            event = set(key: .d, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_a:
            event = set(key: .seven, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_s:
            event = set(key: .eight, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_d:
            event = set(key: .nine, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_f:
            event = set(key: .e, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_z:
            event = set(key: .a, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_x:
            event = set(key: .zero, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_c:
            event = set(key: .b, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        case SDLK_v:
            event = set(key: .f, sdlEvent.key.type == SDL_KEYDOWN.rawValue)
        default:
            break;
        }
        print("event \(event)")
        return event
    }
    
    private func set(key: Key, _ pressed: Bool) -> Input.Event {
        interpreter.keypresses[key] = pressed;
        return pressed ? .keypress(key: key) : .none
    }
}
