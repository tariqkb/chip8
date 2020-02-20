import Chip8Lib
import SDL2

class Audio {
    
    var playingTone: Bool = false
    var sdlAudioSpec: SDL_AudioSpec?
    
    init(tone: Int) {
    }
    
    func handle(interpreter: Interpreter) {
        if interpreter.sound > 0 && !playingTone {
            //play tone
        }
    }
}
