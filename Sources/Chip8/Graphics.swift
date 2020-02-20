import SGLOpenGL
import SDL2
import Chip8Lib
import SGLMath

let SCREEN_WIDTH: Int32 = 800
let SCREEN_HEIGHT: Int32 = 600

class Graphics {
    
    var window: OpaquePointer
    let shader: Shader
    let pixels: PixelRenderer
    let projection: Matrix4x4<GLfloat>
    
    var displayMode: SDL_DisplayMode {
        get {
            var mode = SDL_DisplayMode()
            SDL_GetCurrentDisplayMode(0, &mode)
            return mode
        }
    }
    
    init() {
        
        //let X_POS = Int32(SDL_WINDOWPOS_UNDEFINED_MASK|0), Y_POS=Int32(SDL_WINDOWPOS_UNDEFINED_MASK|0)
        let X_POS: Int32 = 0, Y_POS: Int32 = 0

        guard let window = SDL_CreateWindow("chip8", X_POS, Y_POS, SCREEN_WIDTH, SCREEN_HEIGHT,
                                            SDL_WINDOW_OPENGL.rawValue) else {
            fatalError("sdl - window could not be created error=\(String(cString: SDL_GetError()))")
        }
        self.window = window
        
        // todo - init more opengl stuff
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 4);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, Int32(SDL_GL_CONTEXT_PROFILE_CORE.rawValue));
        
        guard let _ = SDL_GL_CreateContext(window) else {
            fatalError("sdl - couldn't create opengl context error=\(String(cString: SDL_GetError()))")
        }
        
        // Use Vsync
        if(SDL_GL_SetSwapInterval(1) < 0) {
            print("sdl - warning: unable to set vsync error=\(String(cString: SDL_GetError()))");
        }
        
//        glViewport(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)

        self.shader = Shader(vertexSource: """
        #version 330 core
        layout (location = 0) in vec2 vertex;
        layout (location = 1) in vec2 offset;

        uniform mat4 projection;

        void main()
        {
            gl_Position = projection * vec4(vertex.xy + offset, 0.0, 1.0);
        }

        """, fragmentSource: """
        #version 330 core
        out vec4 color;

        uniform vec3 spriteColor;

        void main()
        {
            color = vec4(spriteColor, 1.0);
        }

        """)

        self.pixels = PixelRenderer(shader: shader, color: vec3(1, 1, 1))
        self.projection = SGLMath.ortho(0.0 as GLfloat, 63, 31, 0.0, -1.0, 1.0)
    }
    
    deinit {
        SDL_DestroyWindow(window)
    }
    
    func handle(event: SDL_Event) {
        
    }
    
    func handle(interpreter: Interpreter) {
        glClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        glClear(GL_COLOR_BUFFER_BIT)

        shader.use()

        shader.setUniform("projection", matrix4x4: projection)
        pixels.draw(positions: interpreter.displayVectors)
        
        SDL_GL_SwapWindow(window)
    }
}
