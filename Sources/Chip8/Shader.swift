import Foundation
import SGLOpenGL
import SGLMath
import Darwin

public enum OpenGLResult<T> {
    case success(result: T)
    case error(log: String)
}

public class Shader {

    public private(set) var program: GLuint = 0

    public init(vertexSource: String, fragmentSource: String) {
        let vertexId = glCreateShader(type: GL_VERTEX_SHADER)
        defer { glDeleteShader(vertexId) }
        if case let .error(log) = compileShader(id: vertexId, source: vertexSource) {
            fatalError(log)
        }
        
        let fragmentId = glCreateShader(type: GL_FRAGMENT_SHADER)
        defer { glDeleteShader(fragmentId) }
        if case let .error(log) = compileShader(id: fragmentId, source: fragmentSource) {
            fatalError(log)
        }
        
        self.program = glCreateProgram()
        if case let .error(log) = linkProgram(id: self.program, vertex: vertexId, fragment: fragmentId) {
            fatalError(log)
        }
    }

    public convenience init(vertexFile: String, fragmentFile: String) {
        guard let vertexFilePath = Bundle.main.path(forResource: vertexFile, ofType: "vs") else {
            fatalError("couldn't find shader file \(vertexFile)")
        }
        
        guard let fragmentFilePath = Bundle.main.path(forResource: fragmentFile, ofType: "frag") else {
            fatalError("couldn't find shader file \(fragmentFile)")
        }

        do {
            let vertexSource = try String(contentsOfFile: vertexFilePath, encoding: .utf8)
            let fragmentSource = try String(contentsOfFile: fragmentFilePath, encoding: .utf8)

            self.init(vertexSource: vertexSource, fragmentSource: fragmentSource)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    deinit {
        glDeleteProgram(program)
    }
    
    public func use() {
        glUseProgram(program)
    }
    
    public func setUniform(_ name: String, float value: Float) {
        glUniform1f(glGetUniformLocation(program, name), value)
    }
    
    public func setUniform(_ name: String, matrix4x4 value: Matrix4x4<GLfloat>) {
        var value = value
        withUnsafePointer(to: &value) {
            $0.withMemoryRebound(to: GLfloat.self, capacity: 4 * 4) {
                glUniformMatrix4fv(location: glGetUniformLocation(program, name), count: 1, transpose: false, value: $0)
            }
        }
    }
    
    public func setUniform(_ name: String, vector3 value: Vector3<GLfloat>) {
        var value = value
        withUnsafePointer(to: &value) {
            $0.withMemoryRebound(to: GLfloat.self, capacity: 3) {
                glUniform3fv(location: glGetUniformLocation(program, name), count: 1, value: $0)
            }
        }
    }

}

private func compileShader(id shader: GLuint, source: String) -> OpenGLResult<Void> {
    // compile shader
    source.withCString {
        var s = [$0]
        glShaderSource(shader: shader, count: 1, string: &s, length: nil)
}
    glCompileShader(shader)
    
    // check if compilation succeeded
    var success: GLint = 0
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success)

    guard success == GL_TRUE else {
        // failed to compile
        // get log size
        var logSize: GLint = 0
        glGetShaderiv(shader: shader, pname: GL_INFO_LOG_LENGTH, params: &logSize)
        guard logSize != 0 else {
            return .error(log: "")
        }

        // get log
        var infoLog = [GLchar](repeating: 0, count: Int(logSize))
        glGetShaderInfoLog(shader: shader, bufSize: logSize, length: nil, infoLog: &infoLog)
        
        return .error(log: String(cString: infoLog))
    }
    
    return .success(result: ())
}

private func linkProgram(id program: GLuint, vertex: GLuint, fragment: GLuint) -> OpenGLResult<Void> {
    // link program
    glAttachShader(program, vertex)
    glAttachShader(program, fragment)
    glLinkProgram(program)
    
    // check if linking succeeded
    var success: GLint = 0
    glGetProgramiv(program: program, pname: GL_LINK_STATUS, params: &success)
    
    guard success == GL_TRUE else {
        // linking failed
        // get log size
        var logSize:GLint = 0
        glGetProgramiv(program: program, pname: GL_INFO_LOG_LENGTH, params: &logSize)
        guard logSize != 0 else {
            return .error(log: "")
        }
        
        // get log
        var infoLog = [GLchar](repeating: 0, count: Int(logSize))
        glGetProgramInfoLog(program: program, bufSize: 512, length: nil, infoLog: &infoLog)
        
        return .error(log: String(cString: infoLog))
    }
    
    return .success(result: ())
}
