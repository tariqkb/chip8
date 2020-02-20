import SGLMath
import SGLOpenGL
import CGLFW3

public class PixelRenderer {
    private let shader: Shader
    private let color: Vector3<GLfloat>
    
    private var instanceVBO: GLuint = 0
    private var quadVAO: GLuint = 0
    
    public init(shader: Shader, color: Vector3<GLfloat>) {
        self.shader = shader
        self.color = color
        self.initRenderData()
    }
    
    deinit {
        glDeleteVertexArrays(1, &quadVAO)
    }
    
    public func draw(positions: [Vector2<GLfloat>]) {
        shader.use()
        shader.setUniform("spriteColor", vector3: color)
        
        glBindVertexArray(quadVAO)
        
        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: instanceVBO)
        glBufferData(target: GL_ARRAY_BUFFER, size: MemoryLayout<vec2>.stride * positions.count, data: positions, usage: GL_STATIC_DRAW)
        glBindBuffer(GL_ARRAY_BUFFER, 0)
        
        glEnableVertexAttribArray(1)
        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: instanceVBO)
        glVertexAttribPointer(index: 1, size: 2, type: GL_FLOAT, normalized: false, stride: GLsizei(MemoryLayout<GLfloat>.stride * 2), pointer: nil)
        glBindBuffer(GL_ARRAY_BUFFER, 0)
        glVertexAttribDivisor(1, 1)
        
        glDrawArraysInstanced(GL_TRIANGLES, 0, 6, Int32(positions.count));
        
        glBindVertexArray(0)
    }
    
    private func initRenderData() {
        glGenBuffers(n: 1, buffers: &instanceVBO)
        glGenVertexArrays(n: 1, arrays: &quadVAO)
        
        let vertices: [GLfloat] = [
            0.0, 1.0,
            1.0, 0.0,
            0.0, 0.0,
            0.0, 1.0,
            1.0, 1.0,
            1.0, 0.0
        ]
        
        
        var VBO: GLuint = 0
        glGenBuffers(n: 1, buffers: &VBO)
        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: VBO)
        glBufferData(target: GL_ARRAY_BUFFER, size: MemoryLayout<GLfloat>.stride * vertices.count, data: vertices, usage: GL_STATIC_DRAW)
            
        glBindVertexArray(quadVAO)
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(index: 0, size: 2, type: GL_FLOAT, normalized: false, stride: GLsizei(MemoryLayout<GLfloat>.stride * 2), pointer: nil)
        glBindVertexArray(0);
    }
}
