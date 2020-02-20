//import CGLFW3
//import SGLOpenGL
//import SGLMath
//import Chip8Lib
//
//// todo - fill this out to draw sprite and do opengl
//var drawProgram = Program(instructionBytes: [
//    0x6001, // Load V0 with 0                           | V0 = 0
//    0xF029, // Load location I with sprite              | I = 0x00 (location of 0)
//    0x6100, // Load V1 with 0                           | V1 = 0
//    0x6200, // Load V2 with 0                           | V2 = 0
//    0xD125, // Draw                                     | Draws a 0 at 0,0
//])
//drawProgram.withPause()
//
//var interpreter = Interpreter()
//
//interpreter.load(program: drawProgram)
//
//let WIDTH: GLsizei = 800, HEIGHT: GLsizei = 600
//
//func keyCallback(window: OpaquePointer?, key: Int32, scancode: Int32, action: Int32, mode: Int32) {
//    guard let window = window else {
//        fatalError("window is null")
//    }
//
//    switch (key, action) {
//    case (GLFW_KEY_ESCAPE, GLFW_PRESS):
//        // Press esc
//        glfwSetWindowShouldClose(window, GL_TRUE)
//    case (GLFW_KEY_0, let state):
//        interpreter.keypresses[.zero] = state == GLFW_PRESS
//    default:
//        break
//    }
//}
//
//glfwInit()
//defer { glfwTerminate() }
//
//glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4)
//glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0)
//glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)
//glfwWindowHint(GLFW_RESIZABLE, GL_FALSE)
//glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE)
//
//guard let window = glfwCreateWindow(WIDTH, HEIGHT, "Learn SwiftGL", nil, nil) else {
//    fatalError("failed to create window")
//}
//
//glfwMakeContextCurrent(window)
//
//glViewport(x: 0, y: 0, width: WIDTH, height: HEIGHT)
//
//glfwSetKeyCallback(window, keyCallback)
//
//let shader = Shader(vertexSource: """
//#version 330 core
//layout (location = 0) in vec2 vertex;
//layout (location = 1) in vec2 offset;
//
//uniform mat4 projection;
//
//void main()
//{
//    gl_Position = projection * vec4(vertex.xy + offset, 0.0, 1.0);
//}
//
//""", fragmentSource: """
//#version 330 core
//out vec4 color;
//
//uniform vec3 spriteColor;
//
//void main()
//{
//    color = vec4(spriteColor, 1.0);
//}
//
//""")
//
//let pixels = PixelRenderer(shader: shader, color: vec3(1, 1, 1))
//let projection = SGLMath.ortho(0.0 as GLfloat, 63, 31, 0.0, -1.0, 1.0)
//
//while glfwWindowShouldClose(window) == GL_FALSE {
//    glfwPollEvents()
//
//    // run interpreter
//    if !interpreter.runNext() {
//        glfwSetWindowShouldClose(window, GL_TRUE)
//    }
//
//    glClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
//    glClear(GL_COLOR_BUFFER_BIT)
//
//    shader.use()
//
//    shader.setUniform("projection", matrix4x4: projection)
//    pixels.draw(positions: interpreter.displayVectors)
//
//    glfwSwapBuffers(window)
//}
